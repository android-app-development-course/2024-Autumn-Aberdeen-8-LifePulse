from typing import List

from sqlalchemy import ForeignKey
from sqlalchemy import String, BIGINT, Float, DATE, DATETIME
from sqlalchemy.orm import Mapped
from sqlalchemy.orm import mapped_column
from sqlalchemy.orm import relationship

from .database import Base


class User(Base):
    __tablename__ = "users"

    id: Mapped[int] = mapped_column(BIGINT, primary_key=True, autoincrement=True)
    username: Mapped[str] = mapped_column(String(50), unique=True)
    email: Mapped[str] = mapped_column(String(50), unique=True, nullable=True)
    phone: Mapped[str] = mapped_column(String(50), unique=True)
    hashed_password: Mapped[str] = mapped_column(String(50))

    tokens: Mapped[List["UserToken"]] = relationship("UserToken", back_populates="user")
    posts: Mapped[List["Post"]] = relationship("Post", back_populates="user", passive_deletes=True)
    user_self_info: Mapped["UserSelfInfo"] = relationship("UserSelfInfo", back_populates="user")
    weight_records: Mapped[List["WeightRecord"]] = relationship("WeightRecord", back_populates="user")
    blood_pressure_records: Mapped[List["BloodPressureRecord"]] = relationship("BloodPressureRecord",
                                                                               back_populates="user")
    blood_sugar_records: Mapped[List["BloodSugarRecord"]] = relationship("BloodSugarRecord", back_populates="user")
    heart_rate_records: Mapped[List["HeartRateRecord"]] = relationship("HeartRateRecord", back_populates="user")


class UserToken(Base):
    __tablename__ = "user_tokens"

    id: Mapped[int] = mapped_column(BIGINT, primary_key=True, autoincrement=True)
    user_id: Mapped[int] = mapped_column(BIGINT, ForeignKey("users.id"))
    token: Mapped[str] = mapped_column(String(50))

    user: Mapped[User] = relationship("User")


class UserSelfInfo(Base):
    __tablename__ = "user_self_info"

    id: Mapped[int] = mapped_column(BIGINT, primary_key=True, autoincrement=True)
    user_id: Mapped[int] = mapped_column(BIGINT, ForeignKey("users.id"), nullable=True)
    avatar: Mapped[str] = mapped_column(String(50))
    nickname: Mapped[str] = mapped_column(String(50))
    sex: Mapped[int] = mapped_column(BIGINT)
    height: Mapped[int] = mapped_column(BIGINT)
    birthday: Mapped[str] = mapped_column(DATE)

    user: Mapped[User] = relationship("User", back_populates="user_self_info")


class Post(Base):
    __tablename__ = "posts"

    id: Mapped[int] = mapped_column(BIGINT, primary_key=True, autoincrement=True)
    user_id: Mapped[int] = mapped_column(BIGINT, ForeignKey("users.id"), nullable=True)
    title: Mapped[str] = mapped_column(String(50))
    content: Mapped[str] = mapped_column(String(50))
    created_at: Mapped[str] = mapped_column(DATETIME)
    updated_at: Mapped[str] = mapped_column(DATETIME)

    user: Mapped[User] = relationship("User", back_populates="posts")
    comments: Mapped[List["Comment"]] = relationship("PostComment", back_populates="post")


class Comment(Base):
    __tablename__ = "post_comments"

    id: Mapped[int] = mapped_column(BIGINT, primary_key=True, autoincrement=True)
    post_id: Mapped[int] = mapped_column(BIGINT, ForeignKey("posts.id"))
    user_id: Mapped[int] = mapped_column(BIGINT, ForeignKey("users.id"), nullable=True)
    content: Mapped[str] = mapped_column(String(50))
    created_at: Mapped[str] = mapped_column(DATETIME)
    updated_at: Mapped[str] = mapped_column(DATETIME)

    user: Mapped[User] = relationship("User")
    post: Mapped[Post] = relationship("Post", back_populates="comments")


class WeightRecord(Base):
    __tablename__ = "weight_records"

    id: Mapped[int] = mapped_column(BIGINT, primary_key=True, autoincrement=True)
    user_id: Mapped[int] = mapped_column(BIGINT, ForeignKey("users.id"), nullable=True)
    weight: Mapped[float] = mapped_column(Float)
    created_at: Mapped[str] = mapped_column(DATETIME)

    user: Mapped[User] = relationship("User", back_populates="weight_records")


class BloodPressureRecord(Base):
    __tablename__ = "blood_pressure_records"

    id: Mapped[int] = mapped_column(BIGINT, primary_key=True, autoincrement=True)
    user_id: Mapped[int] = mapped_column(BIGINT, ForeignKey("users.id"), nullable=True)
    systolic_pressure: Mapped[float] = mapped_column(Float)
    diastolic_pressure: Mapped[float] = mapped_column(Float)
    created_at: Mapped[str] = mapped_column(DATETIME)

    user: Mapped[User] = relationship("User", back_populates="blood_pressure_records")


class BloodSugarRecord(Base):
    __tablename__ = "blood_sugar_records"

    id: Mapped[int] = mapped_column(BIGINT, primary_key=True, autoincrement=True)
    user_id: Mapped[int] = mapped_column(BIGINT, ForeignKey("users.id"), nullable=True)
    blood_sugar: Mapped[float] = mapped_column(Float)
    created_at: Mapped[str] = mapped_column(DATETIME)

    user: Mapped[User] = relationship("User", back_populates="blood_sugar_records")


class HeartRateRecord(Base):
    __tablename__ = "heart_rate_records"

    id: Mapped[int] = mapped_column(BIGINT, primary_key=True, autoincrement=True)
    user_id: Mapped[int] = mapped_column(BIGINT, ForeignKey("users.id"), nullable=True)
    heart_rate: Mapped[float] = mapped_column(Float)
    created_at: Mapped[str] = mapped_column(DATETIME)

    user: Mapped[User] = relationship("User", back_populates="heart_rate_records")
