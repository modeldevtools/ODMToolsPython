import logging

import wx
from matplotlib.backends.backend_wxagg import NavigationToolbar2WxAgg as NavigationToolbar
from matplotlib.widgets import Lasso
from matplotlib import path
from matplotlib import dates

# from odmtools.common.logger import LoggerTool
from odmtools.common.icons.plotToolbar import back, filesave, select, scroll_right, \
    scroll_left, zoom_data, zoom_to_rect, subplots, forward, home, move




# tools = LoggerTool()
# logger = tools.setupLogger(__name__, __name__ + '.log', 'w', logging.DEBUG)
logger =logging.getLogger('main')

import matplotlib.dates as mdates
from matplotlib.lines import Line2D
from matplotlib.text import Text
from matplotlib import dates


def bind(actor,event,action,id=None):
        if id is not None:
            event(actor, id, action)
        else:
            event(actor,action)



class MyCustomToolbar(NavigationToolbar):
    '''ON_CUSTOM_LEFT = wx.NewId()
    ON_CUSTOM_RIGHT = wx.NewId()
    ON_CUSTOM_SEL = wx.NewId()
    ON_LASSO_SELECT = wx.NewId()
    ON_ZOOM_DATA_SELECT = wx.NewId()'''

    toolitems = (
        ('Home', 'Reset original view', home, 'home'),
        ('Zoom to Data', 'Zoom to data without NoDataValues', zoom_data, 'on_toggle_zoom_data_tool'),

        ('Back', 'Back to  previous view', back, 'back'),
        ('Forward', 'Forward to next view', forward, 'forward'),
        (None, None, None, None),
        ('Pan', 'Pan axes with left mouse, zoom with right', move, 'pan'),
        ('Zoom', 'Zoom to rectangle', zoom_to_rect, 'zoom'),
        (None, None, None, None),
        ('Subplots', 'Configure subplots', subplots, 'configure_subplots'),
        ('PanLeft', 'Pan graph to the left', scroll_left, '_on_custom_pan_left'),
        ('PanRight', 'Pan graph to the right', scroll_right, '_on_custom_pan_right'),
        ('Save', 'Save the figure', filesave, 'save_figure'),
        ('Select', 'Select datavalues from the graph', select, 'on_toggle_lasso_tool'),
      )




    # rather than copy and edit the whole (rather large) init function, we run
    # the super-classes init function as usual, then go back and delete the
    # buttons we don't want
    def _init_toolbar(self):

        self._parent = self.canvas.GetParent()


        self.wx_ids = {}
        for text, tooltip_text, image_file, callback in self.toolitems:
            if text is None:
                self.AddSeparator()
                continue
            self.wx_ids[text] = wx.NewId()
            if text in ['Pan', 'Zoom', 'Select']:
               self.AddCheckTool(self.wx_ids[text], image_file.GetBitmap(),
                                 shortHelp=text, longHelp=tooltip_text)
            else:
               self.AddSimpleTool(self.wx_ids[text], image_file.GetBitmap(),
                                  text, tooltip_text)
            bind(self, wx.EVT_TOOL, getattr(self, callback), id=self.wx_ids[text])


        #init hover tooltip

        # create a long tooltip with newline to get around wx bug (in v2.6.3.3)
        # where newlines aren't recognized on subsequent self.tooltip.SetTip() calls
        self.tooltip = ToolTip(tip='tip with a long %s line and a newline\n')
        self.canvas.SetToolTip(self.tooltip)
        # self.tooltip.Enable(False)
        self.tooltip.SetDelay(0)

        self.pointPick = self.canvas.mpl_connect('pick_event', self._onPick)



        self.Realize()




    def __init__(self, plotCanvas, multPlots=False, allowselect=False):
        NavigationToolbar.__init__(self, plotCanvas)
        #self.ClearTools()


        # delete the toolbar button we don't want
        if (not multPlots):
            CONFIGURE_SUBPLOTS_TOOLBAR_BTN_POSITION = 8
            self.DeleteToolByPos(CONFIGURE_SUBPLOTS_TOOLBAR_BTN_POSITION)

        #self.AddSimpleTool(self.ON_CUSTOM_LEFT, scroll_left.GetBitmap(), ' Pan to the left', 'Pan graph to the left')
        #self.AddSimpleTool(self.ON_CUSTOM_RIGHT, scroll_right.GetBitmap(), 'Pan to the right', 'Pan graph to the right')

        #wx.EVT_TOOL(self, self.ON_CUSTOM_LEFT, self._on_custom_pan_left)
        #wx.EVT_TOOL(self, self.ON_CUSTOM_RIGHT, self._on_custom_pan_right)

        if allowselect:
            """self.select_tool = self.AddSimpleTool(self.ON_LASSO_SELECT, select.GetBitmap(), 'Lasso Select',
                                                  'Select datavalues from the graph', isToggle=True)

            self.zoom_to_data = self.AddSimpleTool(self.ON_ZOOM_DATA_SELECT, zoom_data.GetBitmap(), 'Zoom to Data',
                                                  'Zoom to data without NoDataValues')

            wx.EVT_TOOL(self, self.ON_LASSO_SELECT, self.on_toggle_lasso_tool)
            wx.EVT_TOOL(self, self.ON_ZOOM_DATA_SELECT, self.on_toggle_zoom_data_tool)"""

            # Get the ids for the existing tools
            self.pan_tool = self.FindById(self.wx_ids['Pan'])
            self.zoom_tool = self.FindById(self.wx_ids['Zoom'])
            self.select_tool=self.FindById(self.wx_ids['Select'])
            self.zoom_to_data = self.FindById(self.wx_ids['Zoom to Data'])

            wx.EVT_TOOL(self, self.zoom_tool.Id, self.on_toggle_pan_zoom)
            wx.EVT_TOOL(self, self.pan_tool.Id, self.on_toggle_pan_zoom)
            self.lassoAction = None
            self.select_tool.Enable(False)
            self.zoom_to_data.Enable(False)

        else:
            ZOOM_DATA_BTN_POSITION = 1
            SELECT_DATA_BTN_POSTITION = self.ToolsCount-1
            self.DeleteToolByPos(SELECT_DATA_BTN_POSTITION)
            self.DeleteToolByPos(ZOOM_DATA_BTN_POSITION)


        self.SetToolBitmapSize(wx.Size(16, 16))

        #msg = wx.StaticText(self, -1, '|')
        #msg.SetForegroundColour((108, 123, 139))

        #self.AddControl(msg)
        self.AddSeparator()

        self.msg = wx.StaticText(self, -1, "")
        self.AddControl(self.msg)

        self.Realize()

    def editSeries(self, xys, edit):
        # enable select button
        self.xys = xys
        self.editCurve = edit
        self.pointPick = self.canvas.mpl_connect('pick_event', self._onPick)
        self.select_tool.Enable(True)
        self.zoom_to_data.Enable(True)
        self.Realize()

    def stopEdit(self):
        try:
            self.canvas.mpl_disconnect(self.pointPick)
            self.pointPick = None
        except AttributeError as e:
            logger.error(e)

        self.canvas.mpl_disconnect(self.lassoAction)
        self.xys = None
        self.editCurve = None
        self.lassoAction = None
        # untoggle select button
        self.ToggleTool(self.select_tool.Id, False)
        # disable select button
        self.select_tool.Enable(False)
        self.zoom_to_data.Enable(False)
        self.Realize()
        #untoggle lasso button
        #self.ToggleTool(self.select_tool.Id, False)


    # pan the graph to the left
    def _on_custom_pan_left(self, evt):
        ONE_SCREEN = 7  # we default to 1 week
        axes = self.canvas.figure.axes[0]
        x1, x2 = axes.get_xlim()
        ONE_SCREEN = (x2 - x1) / 2
        axes.set_xlim(x1 - ONE_SCREEN, x2 - ONE_SCREEN)
        self.canvas.draw()


    # pan the graph to the right
    def _on_custom_pan_right(self, evt):
        ONE_SCREEN = 7  # we default to 1 week
        axes = self.canvas.figure.axes[0]
        x1, x2 = axes.get_xlim()
        ONE_SCREEN = (x2 - x1) / 2
        axes.set_xlim(x1 + ONE_SCREEN, x2 + ONE_SCREEN)
        self.canvas.draw()


    def _onPress(self, event):
        self.myEvent = event
        if event.inaxes is None:
            return
        self.lasso = Lasso(event.inaxes, (event.xdata, event.ydata), self.callback)
        # acquire a lock on the widget drawing
        #self.canvas.widgetlock(self.lasso)

    def callback(self, verts):
        p = path.Path(verts)
        ind = p.contains_points(self.xys)

        df = self.editCurve.dataTable
        #selected_datetime_list = df[ind].LocalDateTime.tolist()
        filtered_datetime_dataframe = df[ind]
        self._parent.lassoChangeSelection(filtered_datetime=filtered_datetime_dataframe)
        #self._parent.lassoChangeSelection(datetime_list=selected_datetime_list)
        self.canvas.draw_idle()
        del self.lasso



    def untoggle_mpl_tools(self):
        """
            This function needs to be called whenever any user-defined tool is clicked e.g. Lasso
        """
        if self.pan_tool.IsToggled():
            wx.PostEvent(self.GetEventHandler(), wx.CommandEvent(wx.EVT_TOOL.typeId, self.pan_tool.Id))
            self.ToggleTool(self.pan_tool.Id, False)
        elif self.zoom_tool.IsToggled():
            wx.PostEvent(self.GetEventHandler(), wx.CommandEvent(wx.EVT_TOOL.typeId, self.zoom_tool.Id))
            self.ToggleTool(self.zoom_tool.Id, False)

    def on_toggle_lasso_tool(self, event):
        """
            Lasso Tool Handler
            event -- button_press_event
        """

        if event.Checked():
            self.untoggle_mpl_tools()
            self.lassoAction = self.canvas.mpl_connect('button_press_event', self._onPress)
        else:
            self.canvas.mpl_disconnect(self.lassoAction)
            self.lassoAction = None

    def on_toggle_pan_zoom(self, event):
        #reset the extents to exclude any no data values
        if event.Checked():

            self.ToggleTool(self.select_tool.Id, False)
            self.canvas.mpl_disconnect(self.lassoAction)
            self.lassoAction = None
        # Make sure the regular pan/zoom handlers get the event
        event.Skip()

    def on_toggle_zoom_data_tool(self, event):
        if self._views.empty():
            self.push_current()
        nodvvals= self.editCurve.dataTable[self.editCurve.dataTable["DataValue"] != self.editCurve.noDataValue]
        #dvs = [x["DataValue"] for x in  if x[0] != self.editCurve.noDataValue]
        #date= [x[1] for x in self.editCurve.dataTable if x[0] != self.editCurve.noDataValue]

        axes = self.canvas.figure.axes[0]
        axes.set_ylim(min(nodvvals["DataValue"]), max(nodvvals["DataValue"]))
        axes.set_xlim(dates.date2num([min(nodvvals.index), max(nodvvals.index)]))

        self.push_current()
        self.canvas.draw()



    def _onMotion(self, event):
        """

        :type event: matplotlib.backend_bases.MouseEvent
        :return:
        """
        try:
            if event.xdata and event.ydata:
                xValue = dates.num2date(event.xdata).replace(tzinfo=None)
                #self.toolbar.msg.SetLabelText("X= %s,  Y= %.2f" % (xValue.strftime("%Y-%m-%d %H:%M:%S"), event.ydata))
                #self.toolbar.msg.SetLabelText("X= %s,  Y= %.2f" % (xValue.strftime("%b %d, %Y %H:%M:%S"), event.ydata))
                self.toolbar.msg.SetLabelText("X= %s,  Y= %.2f" % (xValue.strftime("%b %d, %Y %H:%M"), event.ydata))
                self.toolbar.msg.SetForegroundColour((66, 66, 66))
            else:
                self.toolbar.msg.SetLabelText("")
        except ValueError:
            pass

    def _onPick(self, event):
        """

        :param event:
        :return:
        """

        if isinstance(event.artist, Line2D):
            thisline = event.artist
            xdata = thisline.get_xdata()
            ydata = thisline.get_ydata()
            ind = event.ind

            xValue = xdata[ind][0]
            yValue = ydata[ind][0]
            #tip = '(%s, %s)' % (xValue.strftime("%Y-%m-%d %H:%M:%S"), yValue)
            #tip = '(%s, %s)' % (xValue.strftime("%b %d, %Y %H:%M:%S"), yValue)
            tip = '(%s, %s)' % (xValue.strftime("%b %d, %Y %H:%M"), yValue)

            self.tooltip.SetString(tip)
            self.tooltip.Enable(True)
            self.tooltip.SetAutoPop(10000)

        elif isinstance(event.artist, Text):
            text = event.artist
            #print "Picking Label: ", text.get_text()

    def _onFigureLeave(self, event):
        """Catches mouse leaving the figure

        :param event:
        :return:
        """

        if self.tooltip.Window.Enabled:
            self.tooltip.SetTip("")


#must add these methods for mac functionality
    def release_zoom(self, event):
        super(self.__class__, self).release_zoom(event)
        self.canvas.draw()
    def press_pan(self, event):
        super(self.__class__, self).press_pan(event)
        self.canvas.draw()
    def back(self, event):
        super(self.__class__, self).back(event)
        self.canvas.draw()
    def forward(self, event):
        super(self.__class__, self).forward(event)
        self.canvas.draw()
    def home(self, event):
        super(self.__class__, self).home(event)
        self.canvas.draw()






    def on_scroll_zoom(self, event):
        axes = self.canvas.figure.axes[0]
        base_scale = 1.2
        # get the current x and y limits
        cur_xlim = axes.get_xlim()
        cur_ylim = axes.get_ylim()
        cur_xrange = (cur_xlim[1] - cur_xlim[0])*.5
        cur_yrange = (cur_ylim[1] - cur_ylim[0])*.5
        xdata = event.xdata # get event x location
        ydata = event.ydata # get event y location
        if event.button == 'up':
            # deal with zoom in
            scale_factor = 1/base_scale
        elif event.button == 'down':
            # deal with zoom out
            scale_factor = base_scale
        else:
            # deal with something that should never happen
            scale_factor = 1
            print event.button
        # set new limits
        axes.set_xlim([xdata - cur_xrange*scale_factor,
                     xdata + cur_xrange*scale_factor])
        axes.set_ylim([ydata - cur_yrange*scale_factor,
                     ydata + cur_yrange*scale_factor])
        self.canvas.draw() # force re-draw

    # fig = ax.get_figure() # get the figure of interest
    # attach the call back


class ToolTip(wx.ToolTip):
    """
    a subclass of wx.Tooltip which can be disable on mac
    """

    def __init__(self, tip):
        self.tooltip_string = tip
        self.TooltipsEnabled = True
        wx.ToolTip.__init__(self, tip)

    def SetString(self, tip):
        self.tooltip_string = tip

    def Enable(self, x):
        print ("in custom tooltip set enable")
        if x: self.SetTip(self.tooltip_string)
        else: self.SetTip("")

