from pydantic import BaseModel
from typing import Optional


# Base
class BaseWithId(BaseModel):
    id: int = None


class Record(BaseWithId):
    created_at: str
    updated_at: str


# User
class User(BaseWithId):
    username: str
    email: str
    phone: str


class UserInDB(User):
    hashed_password: str


class Token(BaseWithId):
    access_token: str
    token_type: str


# Info
class UserSelfInfo(BaseWithId):
    avatar: str
    nickname: str
    sex: int
    height: int
    birthday: str


# Post
class Post(Record):
    title: str
    content: str


class PostInDB(Post):
    id: int
    user_id: int


class Comment(Record):
    content: str


class CommentInDB(Comment):
    id: int
    user_id: int
    post_id: int


# Record
class WeightRecord(Record):
    weight: float


class BloodPressureRecord(Record):
    systolic_pressure: int
    diastolic_pressure: int


class BloodSugarRecord(Record):
    blood_sugar: float


class HeartRateRecord(Record):
    heart_rate: int
