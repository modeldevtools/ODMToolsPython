"""Subclass of AddPoints, which is generated by wxFormBuilder."""
import datetime
import wx
from odmtools.controller.frmBulkInsert import BulkInsert
import odmtools.view.clsAddPoints as clsAddPoints
try:
    from agw import genericmessagedialog as GMD
except ImportError:
    import wx.lib.agw.genericmessagedialog as GMD
import logging
logger =logging.getLogger('main')

# Implementing AddPoints
class AddPoints(clsAddPoints.AddPoints):
    def __init__(self, parent, **kwargs):
        if 'recordService' in kwargs:
            self.recordService = kwargs['recordService']
        clsAddPoints.AddPoints.__init__(self, parent, **kwargs)
        self.frame = BulkInsert(self)

    def checkIfEditing(self):
        # Deleting a cell being edited doesn't finish editing
        if self.olv.cellEditor:
            self.olv._PossibleFinishCellEdit()

    # Handlers for AddPoints events.
    def onAddBtn(self, event):
        """

        :param event:
        :return:
        """
        self.checkIfEditing()
        self.olv.AddObject(self.olv.sampleRow())
        event.Skip()

    def onClearAllBtn(self, event):
        """

        :param event:
        :return:
        """
        if len(self.olv.GetObjects()) < 1:
            wx.MessageBox("Nothing to remove here", " ", wx.OK)
            return
        msg = GMD.GenericMessageDialog(None, 'Are you sure you want to delete your work?', 'Clear Everything?', wx.YES_NO | wx.ICON_WARNING |wx.NO_DEFAULT )
        value = msg.ShowModal()
        if value == wx.ID_YES:
            self._clearAll()
        return

    def _clearAll(self):
        self.checkIfEditing()
        self.olv.SetObjects(None)

    def onDeleteBtn(self, event):
        """

        :param event:
        :return:
        """
        self.checkIfEditing()

        try:
            if self.selectedObject:
                if len(self.selectedObject) > 1:
                    length = len(self.selectedObject)
                    msg = GMD.GenericMessageDialog(None, 'Are you sure you want to delete %d items' % length,
                                           'Clear items?',
                                           wx.YES_NO | wx.ICON_WARNING | wx.NO_DEFAULT)
                    value = msg.ShowModal()
                    if value == wx.ID_YES:
                        self.customRemove(self.selectedObject)

                else:
                    self.customRemove(self.selectedObject)
        except TypeError as e:

            msg = GMD.GenericMessageDialog(None, 'Are you sure you want to delete your work?', 'Clear items?',
                                   wx.YES_NO | wx.ICON_WARNING | wx.NO_DEFAULT)
            value = msg.ShowModal()
            if value == wx.ID_YES:
                self.customRemove(self.selectedObject)

                #self.sb.SetStatusText("Removing %s" % self.sb.SetStatusText("Removing %s" % self.selectedObject.dataValue))

        self.selectedObject = None

        event.Skip()

    def customRemove(self, object):
        """


        :param object:
        :return:
        """
        obj = self.olv.GetObjects()
        if isinstance(object, list):
            for x in object:
                obj.remove(x)
        else:
            obj.remove(object)
        self.olv.SetObjects(obj)

    def onUploadBtn(self, event):
        """

        :param event:
        :return:
        """
        self.checkIfEditing()
        if not self.frame.IsShown():
            self.frame.CenterOnParent()
            self.frame.ShowModal()
            self.frame.SetFocus()
        else:
            self.frame.Hide()

        event.Skip()

    def onInfoBtn(self, event):
        """

        :param event:
        :return:
        """
        self.checkIfEditing()

        message = "DataValue: FLOAT\n" \
                  "Date: YYYY-MM-DD\n" \
                  "Time: HH:MM:SS\n" \
                  "UTCOffSet: INT (Range [-12,12])\n" \
                  "CensorCode: gt|nc|lt|nd|pnq\n" \
                  "ValueAccuracy: FLOAT\n" \
                  "OffSetValue: INT\n" \
                  "OffSetType: STRING\n" \
                  "QualifierCode: STRING\n" \
                  "LabSampleCode: STRING\n"

        dlg = GMD.GenericMessageDialog(self, message, "Format Guide",
                                       agwStyle=wx.ICON_INFORMATION | wx.OK | GMD.GMD_USE_GRADIENTBUTTONS)
        dlg.ShowModal()
        event.Skip()

    def onFinishedBtn(self, event):
        """

        :param event:
        :return:
        """
        self.checkIfEditing()

        #try:
        points, isIncorrect = self.parseTable()
        #except:
        #    return

        message = ""

        if not points and not isIncorrect:
            #print "Leaving..."
            self.Close()
            return

        elif not points:
            message = "Unfortunately there are no points to add, " \
                      "please check that the data was entered correctly " \
                      "and try again. "
            dlg = GMD.GenericMessageDialog(None, message, "Nothing to add",
                                           agwStyle=wx.ICON_WARNING | wx.CANCEL | wx.OK | GMD.GMD_USE_GRADIENTBUTTONS)
            dlg.SetOKCancelLabels(ok="Return to AddPoint Menu", cancel="Quit to ODMTools")
            value = dlg.ShowModal()

            if value == wx.ID_OK:
                return
            else:
                self.Close()
                return

        elif isIncorrect:
            message = "Are you ready to add points? " \
                      "There are rows that are incorrectly formatted, " \
                      "those rows will not be added. Continue?"
        else:
            message = "Are you ready to add points? " \
                      "Ready to add points to the database?"

        msg = GMD.GenericMessageDialog(None, message, 'Add Points?',
                               wx.YES_NO | wx.ICON_QUESTION | wx.NO_DEFAULT | GMD.GMD_USE_GRADIENTBUTTONS)

        value = msg.ShowModal()
        if value == wx.ID_NO:
            return

        self.recordService.add_points(points)

        self.Close()
        event.Skip()

    def onSelected(self, event):
        """

        :param event:
        :return:
        """

        obj = event.GetEventObject()
        object = obj.innerList[obj.FocusedItem]
        object = self.olv.GetSelectedObjects()

        try:
            if len(object) > 1:
                self.selectedObject = object
            else:
                self.selectedObject = object[0]
        except TypeError as e:
            pass
        except IndexError as e:
            pass

        event.Skip()

    def parseTable(self):
        """

        :return:
        """

        series = self.recordService.get_series()

        objects = self.olv.GetObjects()

        isIncorrect = False
        points = []

        for i in objects:
            if self.olv.isCorrect(i):
                row = [None] * 10
                if i.valueAccuracy != "NULL":
                    row[1] = i.valueAccuracy
                if i.offSetType != "NULL":
                    row[6] = i.offSetType
                if i.qualifierCode != "NULL":
                    code = i.qualifierCode.split(':')[0]
                    q=self.recordService._edit_service.memDB.series_service.get_qualifier_by_code(code=code)
                    row[8] = q.id
                if i.labSampleCode != "NULL":
                    row[9] = i.labSampleCode

                row[0] = i.dataValue

                dt = self.combineDateTime(i.date, i.time)
                row[2] = dt
                ## UTC Offset
                row[3] = i.utcOffSet
                ## Calculate UTC time based off the localdatetime and utcOffSet
                row[4] = dt - datetime.timedelta(hours=int(i.utcOffSet))
                row[7] = i.censorCode

                row.extend([
                    series.site_id, series.variable_id, series.method_id,
                    series.source_id, series.quality_control_level_id
                    ]
                )

                points.append(tuple(row))
            else:
                isIncorrect = True

        return points, isIncorrect

    def combineDateTime(self, date, time):
        """ Combines date and time into datetime.datetime

        :param date:
            :type datetime.date or str:
        :param time:
            :type str:
        :return:
            :type datetime.datetime:
        """
        newTime = datetime.datetime.strptime(time, "%H:%M:%S").time()

        newDate = date
        if not isinstance(date, datetime.date):
            newDate = datetime.datetime.strptime(date, "%Y-%m-%d").date()

        return datetime.datetime.combine(newDate, newTime)

    def onCheck(self, event):
        object = event.object
        #print "Object: ", object, event.value, event.checkedObjects


class Example(wx.Frame):
    def __init__(self, parent, *args, **kwargs):
        wx.Frame.__init__(self, parent, *args, **kwargs)
        m = AddPoints(parent)
        m.Show()

# Testing Purposes
if __name__ == '__main__':
    app = wx.App()
    ex = Example(None)
    app.MainLoop()
