import os
import pytest
import sqlalchemy
from . import *


def test_func_find_hardest_hw(sqlalchemy_conn):
    path = os.path.join(
        os.getenv("SCRIPTS_DIR"), "functions", "func_find_hardest_hw.sql"
    )
    with sqlalchemy_conn.connect() as conn:
        conn.execute(sqlalchemy.text(read_sql(path)))
        script = conn.execute(
            sqlalchemy.text("SELECT * FROM find_hardest_hw(:name, :surname);"),
            {"name": "Ольга", "surname": "Кузнецова"},
        )
        data = script.fetchall()
        curr_script = pd.DataFrame(data, columns=script.keys())

    assert isinstance(curr_script, pd.DataFrame)
    assert len(curr_script) > 0
    assert (
        curr_script["homework"].iloc[0]
        == 'Написать реферат на тему "Химические элементы и их свойства"'
    )


@pytest.mark.xfail(raises=sqlalchemy.exc.ProgrammingError)
def test_df_raises_exception(sqlalchemy_conn):
    path = os.path.join(
        os.getenv("SCRIPTS_DIR"), "functions", "func_find_hardest_hw.sql"
    )

    with pytest.raises(sqlalchemy.exc.ProgrammingError) as exc_info:
        with sqlalchemy_conn.connect() as conn:
            conn.execute(sqlalchemy.text(read_sql(path)))
            conn.execute(
                sqlalchemy.text("SELECT * FROM find_hardest_hw(:name, :surname);"),
                {"name": "Ольга", "surname": "Кузнецов"},
            )

        assert exc_info.orig.pgcode == "404"


def test_func_find_teacher(sqlalchemy_conn):
    path = os.path.join(
        os.getenv("SCRIPTS_DIR"), "functions", "func_find_teacher.sql"
    )
    with sqlalchemy_conn.connect() as conn:
        conn.execute(sqlalchemy.text(read_sql(path)))
        script = conn.execute(
            sqlalchemy.text("SELECT * FROM find_teacher_with_lowest_grade(:name, :surname);"),
            {"name": "Ольга", "surname": "Кузнецова"},
        )
        data = script.fetchall()
        curr_script = pd.DataFrame(data, columns=script.keys())
    assert isinstance(curr_script, pd.DataFrame)
    assert len(curr_script) == 1
    assert curr_script["lowest_grade"].iloc[0] == 4
