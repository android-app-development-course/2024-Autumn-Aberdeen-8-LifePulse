from fastapi import Depends, HTTPException
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.orm import Session
from starlette import status

from application.orm import crud
from application.orm.database import get_db

# OAuth2
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")


# Dependency
async def get_current_user(db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    user = crud.get_user_by_token(db, token)
    if user is None:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,
                            detail="Invalid authentication credentials",
                            headers={"WWW-Authenticate": "Bearer"})
    return user
