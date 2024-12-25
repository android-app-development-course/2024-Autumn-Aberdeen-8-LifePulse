from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy.orm import Session

# Todo: 之后读取环境变量来获取数据库的连接信息
SQLALCHEMY_DATABASE_URL = "mysql+pymysql://LifePulseAuth:1122@localhost:3306/LifePulseDB"
engine = create_engine(
    SQLALCHEMY_DATABASE_URL, pool_pre_ping=True, pool_recycle=3600
)
# 将ReusableSession作为sessionmaker的class参数传入，使其创建的Session自动回滚
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
