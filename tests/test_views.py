import os
import pandas as pd
from . import execute_sql_to_df
from . import read_sql


def test_view_encrypt_ssn(sqlalchemy_conn):
    path = os.path.join(os.getenv("SCRIPTS_DIR"), "views", "view_encrypt_ssn.sql")
    script = execute_sql_to_df(
        conn=sqlalchemy_conn,
        sql=read_sql(path) + "SELECT * FROM encrypted_social_security_number;",
    )
    assert isinstance(script, pd.DataFrame)
    assert len(script) == 15
    assert script.query("student_id == 11")["encrypted_ssn"].iloc[0] == "63******10"


def test_view_encrypt_teachers_phones(sqlalchemy_conn):
    path = os.path.join(os.getenv("SCRIPTS_DIR"), "views", "view_encrypt_teachers_phones.sql")
    script = execute_sql_to_df(
        conn=sqlalchemy_conn,
        sql=read_sql(path) + "SELECT * FROM encrypt_teachers_phones;",
    )
    assert isinstance(script, pd.DataFrame)
    assert len(script) == 10
    assert (
        script.query("teacher_id == 7")["encrypted_phone_number"].iloc[0]
        == "+7970*****23"
    )


def test_view_student_parent_info(sqlalchemy_conn):
    path = os.path.join(os.getenv("SCRIPTS_DIR"), "views", "view_student_parent_info.sql")
    script = execute_sql_to_df(
        conn=sqlalchemy_conn, sql=read_sql(path) + "SELECT * FROM StudentParentInfo;"
    )
    assert isinstance(script, pd.DataFrame)
    assert len(script) == 20
    assert script.query("student_id == 10")["parent_name"].iloc[1] == "Анастасия"


def test_view_teacher_subject_info(sqlalchemy_conn):
    path = os.path.join(os.getenv("SCRIPTS_DIR"), "views", "view_teacher_subject_info.sql")
    script = execute_sql_to_df(
        conn=sqlalchemy_conn, sql=read_sql(path) + "SELECT * FROM TeacherSubjectInfo;"
    )
    assert isinstance(script, pd.DataFrame)
    assert len(script) == 17
    assert script.query("teacher_id == 1")["subject_name"].iloc[2] == "Информатика"


def test_view_students_statistic(sqlalchemy_conn):
    path = os.path.join(os.getenv("SCRIPTS_DIR"), "views", "view_students_statistic.sql")
    script = execute_sql_to_df(
        conn=sqlalchemy_conn, sql=read_sql(path) + "SELECT * FROM StudentGradeStats;"
    )
    assert isinstance(script, pd.DataFrame)
    assert len(script) == 17
    assert script.query("student_id == 3")["avg_mark"].iloc[0] == 4.5


def test_view_groups_statistic(sqlalchemy_conn):
    path = os.path.join(os.getenv("SCRIPTS_DIR"), "views", "view_groups_statistic.sql")
    script = execute_sql_to_df(
        conn=sqlalchemy_conn, sql=read_sql(path) + "SELECT * FROM GroupStats;"
    )
    assert isinstance(script, pd.DataFrame)
    assert len(script) == 6
    assert script.query("group_id == '311'")["cnt_students"].iloc[0] == 2
