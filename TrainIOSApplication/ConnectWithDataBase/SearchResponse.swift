//
//  SearchResponse.swift
//  TrainIOSApplication
//
//  Created by Тимофей on 12.05.2020.
//  Copyright © 2020 Тимофей. All rights reserved.
//

import Foundation

struct InfoFlight: Decodable{
    var tr_id: Int
    var tr_num: Int
    var tr_type: String
    var fl_id: Int
    var dateArr: String
    var dateSend: String
    var km: Int
    var time_way: Int
    var allplace: Int
}

struct AllVagonFlight: Decodable{
    var tc_name: String
    var count_pl: Int
    var count_vagon: Int
}
struct AllStation: Decodable{
    var r_st: String
}

struct Route: Decodable{
    var r_st: String
    var r_d_t_sed: String
    var r_park: Int
    var r_d_t_arr: String
    var r_km: Int
    var r_time_way: String
}

struct ReservedPlace: Decodable{
    var rc_id: Int
    var pl_num: Int
}

struct NumVagon: Decodable{
    var rc_num: Int
}

struct ReturnTicket: Decodable{
    var tic_id: Int
    var pas_id: Int
    var doc_id: Int
}
