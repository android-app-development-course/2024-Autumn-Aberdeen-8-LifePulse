from sqlalchemy.orm import Session

from .user import get_user
from .. import model, schema


def create_weight_record(db: Session, weight_record: schema.WeightRecord, user_id: int):
    db_weight_record = model.WeightRecord(**weight_record.model_dump(), user_id=user_id)
    db.add(db_weight_record)
    db.commit()
    db.refresh(db_weight_record)
    return db_weight_record


def get_weight_records(db: Session, skip: int = 0, limit: int = 100, user_id: int = None):
    # Check if the user exists
    if get_user(db, user_id) is None:
        return None
    return db.query(model.WeightRecord).filter(model.WeightRecord.user_id == user_id).offset(skip).limit(limit).all()


def create_blood_pressure_record(db: Session, blood_pressure_record: schema.BloodPressureRecord, user_id: int):
    db_blood_pressure_record = model.BloodPressureRecord(**blood_pressure_record.model_dump(), user_id=user_id)
    db.add(db_blood_pressure_record)
    db.commit()
    db.refresh(db_blood_pressure_record)
    return db_blood_pressure_record


def get_blood_pressure_records(db: Session, skip: int = 0, limit: int = 100, user_id: int = None):
    # Check if the user exists
    if get_user(db, user_id) is None:
        return None
    return db.query(model.BloodPressureRecord).filter(model.BloodPressureRecord.user_id == user_id).offset(skip).limit(
        limit).all()


def create_blood_sugar_record(db: Session, blood_sugar_record: schema.BloodSugarRecord, user_id: int):
    db_blood_sugar_record = model.BloodSugarRecord(**blood_sugar_record.model_dump(), user_id=user_id)
    db.add(db_blood_sugar_record)
    db.commit()
    db.refresh(db_blood_sugar_record)
    return db_blood_sugar_record


def get_blood_sugar_records(db: Session, skip: int = 0, limit: int = 100, user_id: int = None):
    # Check if the user exists
    if get_user(db, user_id) is None:
        return None
    return db.query(model.BloodSugarRecord).filter(model.BloodSugarRecord.user_id == user_id).offset(skip).limit(
        limit).all()


def create_heart_rate_record(db: Session, heart_rate_record: schema.HeartRateRecord, user_id: int):
    db_heart_rate_record = model.HeartRateRecord(**heart_rate_record.model_dump(), user_id=user_id)
    db.add(db_heart_rate_record)
    db.commit()
    db.refresh(db_heart_rate_record)
    return db_heart_rate_record


def get_heart_rate_records(db: Session, skip: int = 0, limit: int = 100, user_id: int = None):
    # Check if the user exists
    if get_user(db, user_id) is None:
        return None
    return db.query(model.HeartRateRecord).filter(model.HeartRateRecord.user_id == user_id).offset(skip).limit(
        limit).all()
