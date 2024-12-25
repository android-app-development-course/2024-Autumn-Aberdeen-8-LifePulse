from typing import Type

from sqlalchemy.orm import Session

from .. import model, schema
from ..model import User


def get_user(db: Session, user_id: int) -> Type[model.User] | None:
    return db.query(model.User).filter(model.User.id == user_id).first()


def get_user_by_token(db: Session, token: str) -> Type[model.User] | None:
    return db.query(model.User).join(model.User.tokens).filter(model.UserToken.token == token).first()


def get_user_by_username(db: Session, username: str) -> Type[model.User] | None:
    return db.query(model.User).filter(model.User.username == username).first()


def get_user_by_email(db: Session, email: str) -> Type[model.User] | None:
    return db.query(model.User).filter(model.User.email == email).first()


def get_user_by_phone(db: Session, phone: str) -> Type[model.User] | None:
    return db.query(model.User).filter(model.User.phone == phone).first()


def create_user(db: Session, user: schema.UserInDB) -> User:
    db_user = model.User(**user.model_dump())
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user


def update_user(db: Session, user_id: int, user: schema.UserInDB) -> Type[model.User] | None:
    db_user = get_user(db, user_id)
    for key, value in user.model_dump().items():
        setattr(db_user, key, value)
    db.commit()
    db.refresh(db_user)
    return db_user


def delete_user(db: Session, user_id: int) -> Type[model.User] | None:
    db_user = get_user(db, user_id)
    db.delete(db_user)
    db.commit()
    return db_user


def create_user_token(db: Session, user_id: int, token: str) -> model.UserToken:
    db_token = model.UserToken(user_id=user_id, token=token)
    db.add(db_token)
    db.commit()
    db.refresh(db_token)
    return db_token


def get_user_self_info(db: Session, user_id: int) -> Type[model.UserSelfInfo] | None:
    return get_user(db, user_id).user_self_info


def create_user_self_info(db: Session, user_id: int, user_self_info: schema.UserSelfInfo) -> model.UserSelfInfo:
    db_user_self_info = model.UserSelfInfo(user_id=user_id, **user_self_info.model_dump())
    db.add(db_user_self_info)
    db.commit()
    db.refresh(db_user_self_info)
    return db_user_self_info


def update_user_self_info(db: Session,
                          user_id: int,
                          user_self_info: schema.UserSelfInfo) -> Type[model.UserSelfInfo] | None:
    db_user_self_info = get_user(db, user_id).user_self_info
    for key, value in user_self_info.model_dump().items():
        setattr(db_user_self_info, key, value)
    db.commit()
    db.refresh(db_user_self_info)
    return db_user_self_info
