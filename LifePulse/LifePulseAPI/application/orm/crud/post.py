from sqlalchemy.orm import Session

from .. import model, schema


def get_post(db: Session, post_id: int) -> model.Post | None:
    return db.query(model.Post).filter(model.Post.id == post_id).first()


def get_posts(db: Session, skip: int = 0, limit: int = 100):
    return db.query(model.Post).offset(skip).limit(limit).all()


def create_post(db: Session, post: schema.Post, user_id: int):
    db_post = model.Post(**post.model_dump(), user_id=user_id)
    db.add(db_post)
    db.commit()
    db.refresh(db_post)
    return db_post


def update_post(db: Session, post: schema.PostInDB):
    db_post = get_post(db, post.id)
    for key, value in post.model_dump().items():
        setattr(db_post, key, value)
    db.commit()
    db.refresh(db_post)
    return db_post


def delete_post(db: Session, post_id: int):
    db_post = get_post(db, post_id)
    db.delete(db_post)
    db.commit()
    return db_post


def get_comments(db: Session, post_id: int):
    return get_post(db, post_id).comments


def get_comment(db: Session, comment_id: int):
    return db.query(model.Comment).filter(model.Comment.id == comment_id).first()


def create_comment(db: Session, comment: schema.Comment, post_id: int, user_id: int):
    db_comment = model.Comment(**comment.model_dump(), post_id=post_id, user_id=user_id)
    db.add(db_comment)
    db.commit()
    db.refresh(db_comment)
    return db_comment


def update_comment(db: Session, comment: schema.CommentInDB):
    db_comment = db.query(model.Comment).filter(model.Comment.id == comment.id).first()
    for key, value in comment.model_dump().items():
        setattr(db_comment, key, value)
    db.commit()
    db.refresh(db_comment)
    return db_comment


def delete_comment(db: Session, comment_id: int):
    db_comment = db.query(model.Comment).filter(model.Comment.id == comment_id).first()
    db.delete(db_comment)
    db.commit()
    return db_comment
