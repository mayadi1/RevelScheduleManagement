//
//  Const.swift
//  RevelScheduleManagement
//
//  Created by Keita Ito on 9/8/16.
//  Copyright © 2016 Mohamed Ayadi. All rights reserved.
//

import Foundation



let baseURLString: String = "https://teama-hackathon.revelup.com/resources/TimeSchedule/?employee="
let timePartURLString: String = "&shift_begin_time__gte=2016-09-05"
let apiPartURLString: String = "&api_key=f98be762c10e470aa93da28701457fe8&api_secret=4f35452a0a0b4da695fa605d5e94a6c86ff94c4331524318bf0ab064b190043d"

let allWorksURLString = "https://teama-hackathon.revelup.com/resources/TimeSchedule/?format=json?role=all-roles&time_format=0&range_from=2016-09-05&range_to=2016-09-11&day_start_offset=00:00&all_roles=0&all_departments=0&include_total_wages=1&type=shift&establishment=1&api_key=f98be762c10e470aa93da28701457fe8&api_secret=4f35452a0a0b4da695fa605d5e94a6c86ff94c4331524318bf0ab064b190043d"

let employeesListURLString = "https://teama-hackathon.revelup.com/resources/Employee/?format=json&api_key=f98be762c10e470aa93da28701457fe8&api_secret=4f35452a0a0b4da695fa605d5e94a6c86ff94c4331524318bf0ab064b190043d"