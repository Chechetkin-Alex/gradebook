import os
import pandas as pd
from . import execute_sql_to_df
from . import read_sql


def test_select_best_group(sqlalchemy_conn):
    path = os.path.join(os.getenv("SCRIPTS_DIR"), "queries", "select_best_group.sql")
    script = execute_sql_to_df(conn=sqlalchemy_conn, sql=read_sql(path))
    assert isinstance(script, pd.DataFrame)
    assert len(script) > 0
    assert script["group_id"].iloc[0] == "555"


def test_select_groups(sqlalchemy_conn):
    path = os.path.join(os.getenv("SCRIPTS_DIR"), "queries", "select_groups.sql")
    script = execute_sql_to_df(conn=sqlalchemy_conn, sql=read_sql(path))
    assert isinstance(script, pd.DataFrame)
    assert len(script) == 2
    assert script.query("group_id == '101'")["cnt_members"].iloc[0] == 5
    assert script.query("group_id == '211'")["cnt_members"].iloc[0] == 3


def test_select_improved_students(sqlalchemy_conn):
    path = os.path.join(os.getenv("SCRIPTS_DIR"), "queries", "select_improved_students.sql")
    script = execute_sql_to_df(conn=sqlalchemy_conn, sql=read_sql(path))
    assert isinstance(script, pd.DataFrame)
    assert len(script) > 0
    assert script.query("surname == 'Павлов'")["name"].iloc[0] == "Евгений"


def test_select_nearest_hw(sqlalchemy_conn):
    path = os.path.join(os.getenv("SCRIPTS_DIR"), "queries", "select_nearest_hw.sql")
    script = execute_sql_to_df(conn=sqlalchemy_conn, sql=read_sql(path))
    assert isinstance(script, pd.DataFrame)
    assert len(script) == 6
    assert (script["rank"] == 1).all()
    assert script.query("group_id == '201'")["subject_name"].iloc[0] == "Химия"
    assert script.query("group_id == '555'")["closest_deadline"].iloc[
        0
    ] == pd.Timestamp("2024-03-27 12:00:00")


def test_select_parents_no_networks(sqlalchemy_conn):
    path = os.path.join(os.getenv("SCRIPTS_DIR"), "queries", "select_parents_no_networks.sql")
    script = execute_sql_to_df(conn=sqlalchemy_conn, sql=read_sql(path))
    assert isinstance(script, pd.DataFrame)
    assert len(script) == 1
    assert script["count"].iloc[0] == 4


def test_select_ranked_students(sqlalchemy_conn):
    path = os.path.join(os.getenv("SCRIPTS_DIR"), "queries", "select_ranked_students.sql")
    script = execute_sql_to_df(conn=sqlalchemy_conn, sql=read_sql(path))
    assert isinstance(script, pd.DataFrame)
    assert len(script) == 15
    assert len(script.query("group_id == '201'")) == 2
    assert (
        (
            script.query("group_id == '211' and rank_within_group == 2")[
                ["name", "surname"]
            ]
            == ("Евгений", "Павлов")
        )
        .all()
        .all()
    )


def test_select_strict_teacher(sqlalchemy_conn):
    path = os.path.join(os.getenv("SCRIPTS_DIR"), "queries", "select_strict_teacher.sql")
    script = execute_sql_to_df(conn=sqlalchemy_conn, sql=read_sql(path))
    assert isinstance(script, pd.DataFrame)
    assert len(script) == 1
    assert script["average_mark"].iloc[0] == 4


def test_select_teachers_with_grades(sqlalchemy_conn):
    path = os.path.join(os.getenv("SCRIPTS_DIR"), "queries", "select_teachers_with_grades.sql")
    script = execute_sql_to_df(conn=sqlalchemy_conn, sql=read_sql(path))
    assert isinstance(script, pd.DataFrame)
    assert len(script) == 9
    assert script["average_mark"].round(2).equals(script["average_mark"])
    assert (
        script.query(
            "name == 'Нелли' and surname == 'Панова' and subject_name == 'Информатика'"
        )["average_mark"].iloc[0]
        == 5
    )


def test_select_top_students(sqlalchemy_conn):
    path = os.path.join(os.getenv("SCRIPTS_DIR"), "queries", "select_top_students.sql")
    script = execute_sql_to_df(conn=sqlalchemy_conn, sql=read_sql(path))
    assert isinstance(script, pd.DataFrame)
    assert len(script) == 15
    assert tuple(script.loc[5]) == ("Евгений", "Павлов", 4.5)


def test_select_top_teachers(sqlalchemy_conn):
    path = os.path.join(os.getenv("SCRIPTS_DIR"), "queries", "select_top_teachers.sql")
    script = execute_sql_to_df(conn=sqlalchemy_conn, sql=read_sql(path))
    assert isinstance(script, pd.DataFrame)
    assert len(script) == 3
    assert tuple(script.loc[2]) == ("Всеволод", "Кузнецов", 2)
