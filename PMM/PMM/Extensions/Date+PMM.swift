//
//  Date+PMM.swift
//  PMM
//
//  Created by Vahan Grigoryan on 1/1/23.
//

import Foundation

extension Date {
	var startOfDay: Date {
		return Calendar.current.startOfDay(for: self)
	}

	var startOfMonth: Date {

		let calendar = Calendar(identifier: .gregorian)
		let components = calendar.dateComponents([.year, .month], from: self)

		return  calendar.date(from: components)!
	}

	var endOfMonth: Date {
				 var components = DateComponents()
				 components.month = 1
				 components.second = -1
				 return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
		 }
}

extension Calendar {
		func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
				let fromDate = startOfDay(for: from) // <1>
				let toDate = startOfDay(for: to) // <2>
				let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>

				return numberOfDays.day!
		}
}
