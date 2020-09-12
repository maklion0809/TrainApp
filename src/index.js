const express = require("express");
const sqlite = require("better-sqlite3");
const { join } = require("path");
var add = require('date-fns/add')

const app = express();

const port = 3000;

const dbFile = join("data", "TrainDB.db");

const api = express.Router();

console.log(`Путь к файлу БД: ${dbFile}`);

const db = sqlite(dbFile);

db.prepare(
  "create table if not exists 'train' ('id' integer not null primary key autoincrement, 'name' text not null, 'num' integer not null);"
).run();

app.use(express.json());

api.get("/get/:table/", (req, res) => {
  if (req.params.table) {
    try {
      const data = db.prepare(`select * from ${req.params.table};`).all();
      if (data) {
        res.status(200).json(data);
      } else {
        res.sendStatus(204);
      }
    } catch (err) {
      console.log(err);
      res.sendStatus(500);
    }
  }
});

api.get("/getStation", (req, res) => {
  try {
    const data = db.prepare(`select DISTINCT(r_st) from route;`).all();
    if (data) {
      res.status(200).json(data);
    } else {
      res.sendStatus(204);
    }
  } catch (err) {
    console.log(err);
    res.sendStatus(500);
  }
});

api.get("/getRoute", ({ query: { from, to, date, time } }, res) => {
  try {
    const data = db
      .prepare(
        `select tr.tr_id, tr.tr_num, tr.tr_type, fl.fl_id,(select r_d_t_arr from route r join flight fl on r.fl_id = fl.fl_id where fl.fl_id in (select fl.fl_id from train tr join flight fl on tr.tr_id=fl.tr_id where fl.fl_id in (select fl.fl_id from route r join flight fl on r.fl_id=fl.fl_id where date(r.r_d_t_arr) = '${date}' and time(r.r_d_t_arr) > '${time}' and r.r_st = '${from}'  INTERSECT select fl.fl_id from route r join flight fl on r.fl_id=fl.fl_id where r.r_st = '${to}' and r.r_km > (select r.r_km from route r join flight fl on r.fl_id=fl.fl_id where date(r.r_d_t_arr) = '${date}' and time(r.r_d_t_arr) > '${time}' and r.r_st = '${from}' ))) and r.r_st = '${from}') as dateArr, (select r_d_t_sed from route r join flight fl on r.fl_id = fl.fl_id where fl.fl_id in (select fl.fl_id from train tr join flight fl on tr.tr_id=fl.tr_id where fl.fl_id in (select fl.fl_id from route r join flight fl on r.fl_id=fl.fl_id where date(r.r_d_t_arr) = '${date}' and time(r.r_d_t_arr) > '${time}' and r.r_st = '${from}'  INTERSECT select fl.fl_id from route r join flight fl on r.fl_id=fl.fl_id where r.r_st = '${to}' and r.r_km > (select r.r_km from route r join flight fl on r.fl_id=fl.fl_id where date(r.r_d_t_arr) = '${date}' and time(r.r_d_t_arr) > '${time}' and r.r_st = '${from}' ))) and r.r_st = '${to}') as dateSend ,((select r_km from route r join flight fl on r.fl_id = fl.fl_id where fl.fl_id in (select fl.fl_id from train tr join flight fl on tr.tr_id=fl.tr_id where fl.fl_id in (select fl.fl_id from route r join flight fl on r.fl_id=fl.fl_id where date(r.r_d_t_arr) = '${date}' and time(r.r_d_t_arr) > '${time}' and r.r_st = '${from}'  INTERSECT select fl.fl_id from route r join flight fl on r.fl_id=fl.fl_id where r.r_st = '${to}' and r.r_km > (select r.r_km from route r join flight fl on r.fl_id=fl.fl_id where date(r.r_d_t_arr) = '${date}' and time(r.r_d_t_arr) > '${time}' and r.r_st = '${from}' ))) and r_st = '${to}')-(select r_km from route r join flight fl on r.fl_id = fl.fl_id where fl.fl_id in (select fl.fl_id from train tr join flight fl on tr.tr_id=fl.tr_id where fl.fl_id in (select fl.fl_id from route r join flight fl on r.fl_id=fl.fl_id where date(r.r_d_t_arr) = '${date}' and time(r.r_d_t_arr) > '${time}' and r.r_st = '${from}'  INTERSECT select fl.fl_id from route r join flight fl on r.fl_id=fl.fl_id where r.r_st = '${to}' and r.r_km > (select r.r_km from route r join flight fl on r.fl_id=fl.fl_id where date(r.r_d_t_arr) = '${date}' and time(r.r_d_t_arr) > '${time}' and r.r_st = '${from}' ))) and r_st = '${from}')) as km, ((select strftime('%s',r_time_way) from route r join flight fl on r.fl_id = fl.fl_id where fl.fl_id in (select fl.fl_id from train tr join flight fl on tr.tr_id=fl.tr_id where fl.fl_id in (select fl.fl_id from route r join flight fl on r.fl_id=fl.fl_id where date(r.r_d_t_arr) = '${date}' and time(r.r_d_t_arr) > '${time}' and r.r_st = '${from}'  INTERSECT select fl.fl_id from route r join flight fl on r.fl_id=fl.fl_id where r.r_st = '${to}' and r.r_km > (select r.r_km from route r join flight fl on r.fl_id=fl.fl_id where date(r.r_d_t_arr) = '${date}' and time(r.r_d_t_arr) > '${time}' and r.r_st = '${from}' ))) and r_st = '${to}')-(select strftime('%s',r_time_way) from route r join flight fl on r.fl_id = fl.fl_id where fl.fl_id in (select fl.fl_id from train tr join flight fl on tr.tr_id=fl.tr_id where fl.fl_id in (select fl.fl_id from route r join flight fl on r.fl_id=fl.fl_id where date(r.r_d_t_arr) = '${date}' and time(r.r_d_t_arr) > '${time}' and r.r_st = '${from}'  INTERSECT select fl.fl_id from route r join flight fl on r.fl_id=fl.fl_id where r.r_st = '${to}' and r.r_km > (select r.r_km from route r join flight fl on r.fl_id=fl.fl_id where date(r.r_d_t_arr) = '${date}' and time(r.r_d_t_arr) > '${time}' and r.r_st = '${from}' ))) and r_st = '${from}')) as time_way, (select count(pl_num) from place where pl_id not in (select pl_id from ticket) and rc_id in (select rc_id from railway_carriage rc join train tr on rc.tr_id=tr.tr_id where tr.tr_id in (select tr.tr_id from train tr join flight fl on tr.tr_id=fl.tr_id where fl.fl_id in (select fl.fl_id from route r join flight fl on r.fl_id=fl.fl_id where date(r.r_d_t_arr) = '${date}' and time(r.r_d_t_arr) > '${time}' and r.r_st = '${from}'  INTERSECT select fl.fl_id from route r join flight fl on r.fl_id=fl.fl_id where r.r_st = '${to}' and r.r_km > (select r.r_km from route r join flight fl on r.fl_id=fl.fl_id where date(r.r_d_t_arr) = '${date}' and time(r.r_d_t_arr) > '${time}' and r.r_st = '${from}' ))))) as allplace from train tr join flight fl on tr.tr_id=fl.tr_id where fl.fl_id in (select fl.fl_id from route r join flight fl on r.fl_id=fl.fl_id where date(r.r_d_t_arr) = '${date}' and time(r.r_d_t_arr) > '${time}' and r.r_st = '${from}'  INTERSECT select fl.fl_id from route r join flight fl on r.fl_id=fl.fl_id where r.r_st = '${to}' and r.r_km > (select r.r_km from route r join flight fl on r.fl_id=fl.fl_id where date(r.r_d_t_arr) = '${date}' and time(r.r_d_t_arr) > '${time}' and r.r_st = '${from}'));`
        )
      .all();
    if (data.length) {
      res.status(200).json(data);
    } else {
      res.sendStatus(204);
    }
  } catch (err) {
    console.log(err);
    res.sendStatus(500);
  }
});



api.get("/getVagon/:id/", (req, res) => {
  if (req.params.id) {
    try {
      const data = db
        .prepare(
          `select tc.tc_name, count(pl.pl_id) as count_pl, count(DISTINCT(rc.rc_id)) as count_vagon from type_of_car tc join railway_carriage rc on tc.tc_id = rc.tc_id join place pl on rc.rc_id=pl.rc_id where pl.pl_id not in (select pl_id from ticket) and rc.rc_id in (select rc_id from railway_carriage rc join train tr on rc.tr_id=tr.tr_id where tr.tr_id = ${req.params.id}) group by 1;`
        )
        .all();
      if (data.length) {
        res.status(200).json(data);
      } else {
        res.sendStatus(204);
      }
    } catch (err) {
      console.log(err);
      res.sendStatus(500);
    }
  } else {
    res.sendStatus(401);
  }
});

api.get("/getR/:fl_id", (req, res) => {
  try {
    const data = db
      .prepare(
        `select r_st, r_d_t_sed, r_park, r_d_t_arr, r_km, r_time_way from route where fl_id = ${req.params.fl_id};`
        )
      .all();
    if (data.length) {
      res.status(200).json(data);
    } else {
      res.sendStatus(204);
    }
  } catch (err) {
    console.log(err);
    res.sendStatus(500);
  }
});
api.get("/getSpecV", ({ query: { train, vagon } }, res) => {
  try {
    const data = db
      .prepare(
        `Select rc_id, pL_num from place where pl_id in(select pl_id from ticket) and rc_id in(select rc_id from railway_carriage rc join train tr on rc.tr_id=tr.tr_id join type_of_car tc on tc.tc_id=rc.tc_id where tr.tr_id = ${train} and tc.tc_name = '${vagon}');`
      )
      .all();
    if (data.length) {
      res.status(200).json(data);
    } else {
      res.sendStatus(204);
    }
  } catch (err) {
    console.log(err);
    res.sendStatus(500);
  }
});

api.get("/getNumVagon", ({ query: { train, vagon} }, res) => {
  try {
    const data = db
      .prepare(
        `select rc.rc_num from railway_carriage rc join type_of_car tc on rc.tc_id = tc.tc_id join train tr on rc.tr_id=tr.tr_id where tr.tr_id = ${train} and tc.tc_name = '${vagon}';`
      )
      .all();
    if (data.length) {
      res.status(200).json(data);
    } else {
      res.sendStatus(204);
    }
  } catch (err) {
    console.log(err);
    res.sendStatus(500);
  }
});
api.get("/getTicket", ({ query: {num}}, res) => {
  try {
    const data = db
      .prepare(
        `select tic.tic_id, pas.pas_id, doc.doc_id from ticket tic join passenger pas on tic.pas_id=pas.pas_id join document doc on pas.doc_id=doc.doc_id where tic.tic_num = '${num}';`
      )
      .all();
    if (data.length) {
      res.status(200).json(data);
    } else {
      res.sendStatus(204);
    }
  } catch (err) {
    console.log(err);
    res.sendStatus(500);
  }
});

api.delete("/deleteServer", ({ query: {tic_id}}, res) => {
  try {
   const data = db.prepare(`delete from ser_tic where tic_id = ${tic_id};`).run();
    res.status(200).send(data);
  } catch (err) {
    console.log(err);
    res.sendStatus(500);
  }
});

api.delete("/deleteTicket", ({ query: {tic_id}}, res) => {
  try {
   const data = db.prepare(`delete from ticket where tic_id = ${tic_id};`).run();
    res.status(200).send(data);
  } catch (err) {
    console.log(err);
    res.sendStatus(500);
  }
});

api.delete("/deletePassenger", ({ query: {pas_id}}, res) => {
  try {
   const data = db.prepare(`delete from passenger where pas_id = ${pas_id};`).run();
    res.status(200).send(data);
  } catch (err) {
    console.log(err);
    res.sendStatus(500);
  }
});

api.delete("/deleteDocument", ({ query: {doc_id}}, res) => {
  try {
   const data = db.prepare(`delete from document where doc_id = ${doc_id};`).run();
    res.status(200).send(data);
  } catch (err) {
    console.log(err);
    res.sendStatus(500);
  }
});

api.post("/addPasDoc", ({ query: {doc_type, doc_num} }, res) => {
  try {
    const info = db.prepare(`insert into document (doc_type, doc_num) VALUES ('${doc_type}' ,'${doc_num}');`).run();
    res.status(200).send(info);
  } catch (err) {
    console.log(err);
    res.sendStatus(500);
  }
});

api.post("/addPasInfo", ({ query: {pas_name, pas_surname, pas_email} }, res) => {
  try {
    const info = db
       .prepare(
          `insert into passenger(pas_name, pas_surname, pas_email, doc_id) VALUES ('${pas_name}', '${pas_surname}', '${pas_email}', (select max(doc_id) from document));`
      )
      .run();
    res.status(200).send(info);
  } catch (err) {
    console.log(err);
    res.sendStatus(500);
  }
});

api.post("/addPasTic", ({ query: {tic_price, fl_id, r_st_begin, r_st_end, tr_id, rc_num, pl_num, tic_num} }, res) => {
  try {
    const info = db
       .prepare(
          `insert into ticket (tic_price, tic_d_t, tic_res, pas_id, r_st_begin, r_st_end, pl_id, tic_num) VALUES (${tic_price}, datetime('now','+3 hours') , 1, (select max(pas_id) from passenger), (select r_id from route where fl_id = ${fl_id} and r_st = '${r_st_begin}'), (select r_id from route where fl_id = ${fl_id} and r_st = '${r_st_end}'), (select pl.pl_id from place pl join railway_carriage rc on pl.rc_id=rc.rc_id join train tr on rc.tr_id=tr.tr_id where tr.tr_id = ${tr_id} and rc.rc_num = ${rc_num} and pl.pl_num = ${pl_num}), '${tic_num}');`
      )
      .run();
    res.status(200).send(info);
  } catch (err) {
    console.log(err);
    res.sendStatus(500);
  }
});

api.post("/addPasSer", ({ query: {num} }, res) => {
  try {
    const info = db
       .prepare(
          `insert into ser_tic( ts_id, tic_id) VALUES (${num},(SELECT max(tic_id) from ticket));`
      )
      .run();
    res.status(200).send(info);
  } catch (err) {
    console.log(err);
    res.sendStatus(500);
  }
});
db.prepare(
  `delete from document where doc_id in (SELECT doc.doc_id from route r join ticket tic on r.r_id=tic.r_st_begin join passenger pas on tic.pas_id=pas.pas_id join document doc on doc.doc_id=pas.doc_id where datetime(r.r_d_t_arr) < datetime('now','+3 hours'));`
).run();

db.prepare(
  `DELETE from passenger where pas_id in (SELECT pas.pas_id from route r join ticket tic on r.r_id=tic.r_st_begin join passenger pas on tic.pas_id=pas.pas_id  where datetime(r.r_d_t_arr) < datetime('now','+3 hours'));`
).run();

db.prepare(
  `DELETE from ser_tic where ts_id in (SELECT ts.ts_id from route r join ticket tic on r.r_id=tic.r_st_begin join ser_tic ts on ts.tic_id=tic.tic_id where datetime(r.r_d_t_arr) < datetime('now','+3 hours'));`
).run();

db.prepare(
  `DELETE from ticket where tic_id in (SELECT tic.tic_id from route r join ticket tic on r.r_id=tic.r_st_begin  where datetime(r.r_d_t_arr) < datetime('now','+3 hours'));`
).run();


db.prepare(
  `delete from flight where fl_d_t_end < datetime('now','+3 hours');`
).run();


app.use("/api", api);

app.listen(port, () => {
  console.log(`Listening at http://localhost:${port}`);
});
