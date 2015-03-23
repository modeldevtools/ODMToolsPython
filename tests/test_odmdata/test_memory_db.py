import pytest

from odmtools.odmdata import MemoryDatabase
from odmtools.odmservices import SeriesService
from tests import test_util


class TestMemoryDB:
    def setup(self):
        self.connection_string = "sqlite:///:memory:"
        self.series_service = SeriesService(connection_string=self.connection_string, debug=False)
        self.session = self.series_service._session_factory.get_session()
        engine = self.series_service._session_factory.engine
        test_util.build_db(engine)
        self.series = test_util.add_series(self.session)

        self.memory_db = MemoryDatabase()
        self.memory_db.set_series_service(self.series_service)
        self.series = test_util.add_series(self.session)
        self.memory_db.initEditValues(self.series.id)
    '''
    def test_delete_points(self):
        #with pytest.raises(NotImplementedError):
        self.memory_db.delete_points("filter")

    def test_update_points(self):
        with pytest.raises(NotImplementedError):
            self.memory_db.update_points("filter", [1, 2, 3])
    '''

    def test_add_points(self):
        #with pytest.raises(NotImplementedError):
        point = ['-9999', '2005-06-29', '14:20:15', '-7', 'nc', "1.2", "1", "NULL", "NULL", "NULL"]
        point.extend([
                    self.series.site_id, self.series.variable_id, self.series.method_id,
                    self.series.source_id, self.series.quality_control_level_id
                    ]
                )
        print point
        self.memory_db.addPoints(point)


    def test_get_data_values(self):
        dvs = self.memory_db.getDataValues()
        assert len(dvs) == 10