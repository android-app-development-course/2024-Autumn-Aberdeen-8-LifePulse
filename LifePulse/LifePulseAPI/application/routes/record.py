from typing import Union

from fastapi import APIRouter, HTTPException, status, Depends
from sqlalchemy.orm import Session

from . import get_current_user
from ..orm import crud, schema, model
from ..orm.database import get_db

router = APIRouter()


@router.post("/records/Weight")
async def create_weight_record(record: schema.WeightRecord,
                               current_user: Union[model.User, None] = Depends(get_current_user),
                               db: Session = Depends(get_db)) -> schema.WeightRecord:
    db_record = crud.create_weight_record(db, record, current_user.id)
    return schema.WeightRecord(**db_record.__dict__)


@router.get("/records/Weight")
async def read_weight_records(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)) -> list[
                                                                                                     schema.WeightRecord] | None:
    db_records = crud.get_weight_records(db, skip, limit)
    records = []
    for db_record in db_records:
        records.append(schema.WeightRecord(**db_record.__dict__))
    return records


@router.post("/records/BloodPressure")
async def create_blood_pressure_record(record: schema.BloodPressureRecord,
                                       current_user: Union[model.User, None] = Depends(get_current_user),
                                       db: Session = Depends(get_db)) -> schema.BloodPressureRecord:
    db_record = crud.create_blood_pressure_record(db, record, current_user.id)
    return schema.BloodPressureRecord(**db_record.__dict__)


@router.get("/records/BloodPressure")
async def read_blood_pressure_records(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)) -> list[
                                                                                                             schema.BloodPressureRecord] | None:
    db_records = crud.get_blood_pressure_records(db, skip, limit)
    records = []
    for db_record in db_records:
        records.append(schema.BloodPressureRecord(**db_record.__dict__))
    return records


@router.post("/records/BloodSugar")
async def create_blood_sugar_record(record: schema.BloodSugarRecord,
                                    current_user: Union[model.User, None] = Depends(get_current_user),
                                    db: Session = Depends(get_db)) -> schema.BloodSugarRecord:
    db_record = crud.create_blood_sugar_record(db, record, current_user.id)
    return schema.BloodSugarRecord(**db_record.__dict__)


@router.get("/records/BloodSugar")
async def read_blood_sugar_records(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)) -> list[
                                                                                                          schema.BloodSugarRecord] | None:
    db_records = crud.get_blood_sugar_records(db, skip, limit)
    records = []
    for db_record in db_records:
        records.append(schema.BloodSugarRecord(**db_record.__dict__))
    return records


@router.post("/records/HeartRate")
async def create_heart_rate_record(record: schema.HeartRateRecord,
                                   current_user: Union[model.User, None] = Depends(get_current_user),
                                   db: Session = Depends(get_db)) -> schema.HeartRateRecord:
    db_record = crud.create_heart_rate_record(db, record, current_user.id)
    return schema.HeartRateRecord(**db_record.__dict__)


@router.get("/records/HeartRate")
async def read_heart_rate_records(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    return crud.get_heart_rate_records(db, skip, limit)
