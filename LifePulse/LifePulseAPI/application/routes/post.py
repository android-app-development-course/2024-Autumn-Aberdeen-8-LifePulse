from typing import Union

from fastapi import APIRouter, HTTPException, status, Depends
from sqlalchemy.orm import Session

from . import get_current_user
from ..orm import crud, schema, model
from ..orm.database import get_db

router = APIRouter()


@router.post("/posts")
async def create_post(post: schema.Post, current_user: Union[model.User, None] = Depends(get_current_user),
                      db: Session = Depends(get_db)) -> schema.Post | None:
    db_post = crud.create_post(db, post, current_user.id)
    return schema.Post(**db_post.__dict__)


@router.get("/posts")
async def read_posts(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)) -> list[schema.Post] | None:
    db_posts = crud.get_posts(db, skip, limit)
    posts = []
    for db_post in db_posts:
        posts.append(schema.Post(**db_post.__dict__))
    return posts


@router.get("/posts/{post_id}")
async def read_post(post_id: int, db: Session = Depends(get_db)) -> schema.Post | None:
    # Check if the post exists
    if crud.get_post(db, post_id) is None:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Post does not exist")
    return schema.Post(**crud.get_post(db, post_id).__dict__)


@router.put("/posts")
async def update_post(post: schema.PostInDB, current_user: Union[model.User, None] = Depends(get_current_user),
                      db: Session = Depends(get_db)) -> schema.Post | None:
    # Check if the post exists
    if crud.get_post(db, post.id) is None:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Post does not exist")
    # Check if the post belongs to the user
    if crud.get_post(db, post.id).user.id != current_user.id:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="You are not the author of this post")
    return schema.Post(**crud.update_post(db, post).__dict__)


@router.delete("/posts/{post_id}")
async def delete_post(post_id: int, current_user: Union[model.User, None] = Depends(get_current_user),
                      db: Session = Depends(get_db)) -> schema.Post | None:
    # Check if the post exists
    if crud.get_post(db, post_id) is None:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Post does not exist")
    # Check if the post belongs to the user
    if crud.get_post(db, post_id).user.id != current_user.id:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="You are not the author of this post")
    return schema.Post(**crud.delete_post(db, post_id).__dict__)


@router.get("/posts/{post_id}/comments")
async def read_comments(post_id: int, db: Session = Depends(get_db)) -> list[schema.Comment] | None:
    # Check if the post exists
    if crud.get_post(db, post_id) is None:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Post does not exist")
    db_comments = crud.get_comments(db, post_id)
    comments = []
    for db_comment in db_comments:
        comments.append(schema.Comment(**db_comment.__dict__))
    return comments


@router.post("/posts/{post_id}/comments")
async def create_comment(comment: schema.Comment, post_id: int,
                         current_user: Union[model.User, None] = Depends(get_current_user),
                         db: Session = Depends(get_db)) -> schema.Comment | None:
    # Check if the post exists
    if crud.get_post(db, post_id) is None:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Post does not exist")
    db_comment = crud.create_comment(db, comment, post_id, current_user.id)
    return schema.Comment(**db_comment.__dict__)


@router.put("/posts/{post_id}/comments")
async def update_comment(comment: schema.CommentInDB, current_user: Union[model.User, None] = Depends(get_current_user),
                         db: Session = Depends(get_db)) -> schema.Comment | None:
    # Check if the comment exists
    if crud.get_comment(db, comment.id) is None:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Comment does not exist")
    # Check if the comment belongs to the user
    if crud.get_comment(db, comment.id).user.id != current_user.id:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="You are not the author of this comment")
    return crud.update_comment(db, comment)


@router.delete("/posts/{post_id}/comments/{comment_id}")
async def delete_comment(comment_id: int, current_user: Union[model.User, None] = Depends(get_current_user),
                         db: Session = Depends(get_db)) -> schema.Comment | None:
    # Check if the comment exists
    if crud.get_comment(db, comment_id) is None:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Comment does not exist")
    # Check if the comment belongs to the user
    if crud.get_comment(db, comment_id).user.id != current_user.id:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="You are not the author of this comment")
    return crud.delete_comment(db, comment_id)
