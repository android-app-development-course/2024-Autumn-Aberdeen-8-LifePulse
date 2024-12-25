import datetime
from datetime import datetime
from hashlib import sha256
from typing import Union

from fastapi import APIRouter, HTTPException, status, Depends
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session

from . import get_current_user
from ..orm import crud, schema, model
from ..orm.database import get_db

router = APIRouter()


def create_token(data: dict):
    un_hashed_str = f"{data['username']}:xueyeGuard:{datetime.now()}"
    hashed_str = sha256(un_hashed_str.encode()).hexdigest()
    return hashed_str


# Routers
@router.post("/token")
async def login_for_access_token(form_data: OAuth2PasswordRequestForm = Depends(),
                                 db: Session = Depends(get_db)) -> dict:
    user = crud.get_user_by_username(db, form_data.username)
    if user is None:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Incorrect username or password")
    if user.hashed_password != form_data.password:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Incorrect username or password")
    return {"access_token": create_token({"username": form_data.username, "password": form_data.password}),
            "token_type": "bearer"}


@router.get("/users/me")
async def read_users_me(current_user: Union[model.User, None] = Depends(get_current_user)) -> schema.User:
    return schema.User(**current_user.__dict__)


@router.post("/users")
async def create_user(user: schema.UserInDB, self_info: schema.UserSelfInfo,
                      db: Session = Depends(get_db)) -> schema.User:
    # Check if the user already exists
    if crud.get_user_by_username(db, user.username) is not None:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Username already exists")
    if crud.get_user_by_email(db, user.email) is not None:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Email already exists")
    if crud.get_user_by_phone(db, user.phone) is not None:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Phone already exists")
    # Create user
    db_user = crud.create_user(db, user)
    # Create user self info
    db_user_self_info = crud.create_user_self_info(db, db_user.id, self_info)
    return schema.User(**db_user.__dict__)


@router.get("/users/{user_id}")
async def read_user(user_id: int, db: Session = Depends(get_db)) -> schema.User:
    db_user = crud.get_user(db, user_id)
    if db_user is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="User not found")
    return schema.User(**db_user.__dict__)


# Modify user info
@router.put("/users/me")
async def update_user(modify_info: schema.UserInDB, current_user: Union[model.User, None] = Depends(get_current_user),
                      db: Session = Depends(get_db)) -> schema.User:
    db_user = crud.update_user(db, current_user.id, modify_info)
    return schema.User(**db_user.__dict__)


@router.put("/users/me/self_info")
async def update_user_self_info(modify_info: schema.UserSelfInfo,
                                current_user: Union[model.User, None] = Depends(get_current_user),
                                db: Session = Depends(get_db)) -> schema.UserSelfInfo:
    db_user_self_info = crud.update_user_self_info(db, current_user.id, modify_info)
    return schema.UserSelfInfo(**db_user_self_info.__dict__)


@router.delete("/users/me")
async def delete_user(current_user: Union[model.User, None] = Depends(get_current_user),
                      db: Session = Depends(get_db)) -> schema.User:
    db_user = crud.delete_user(db, current_user.id)
    return schema.User(**db_user.__dict__)
