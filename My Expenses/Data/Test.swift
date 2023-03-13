//
//  Test.swift
//  My Expenses
//
//  Created by Wind Versi on 13/3/23.
//

import Foundation

class TestData {
    
    static var sampleDayExpenses: [DayExpense] = [
        .init(
            date: "2023-02-01T00:00:00+00:00".toDate(),
            items: []
        ),
        .init(
            date: "2023-02-02T00:00:00+00:00".toDate(),
            items: []
        ),
        .init(
            date: "2023-02-03T00:00:00+00:00".toDate(),
            items: []
        ),
        .init(
            date: "2023-02-04T00:00:00+00:00".toDate(),
            items: []
        ),
        .init(
            date: "2023-02-05T00:00:00+00:00".toDate(),
            items: []
        ),
        .init(
            date: "2023-02-06T00:00:00+00:00".toDate(),
            items: []
        ),
        .init(
            date: "2023-02-07T00:00:00+00:00".toDate(),
            items: []
        )
    ]
    
    static var sampleDayExpenses2: [DayExpense] = [
        .init(
            date: "2023-02-08T00:00:00+00:00".toDate(),
            items: []
        ),
        .init(
            date: "2023-02-09T00:00:00+00:00".toDate(),
            items: []
        ),
        .init(
            date: "2023-02-10T00:00:00+00:00".toDate(),
            items: []
        ),
        .init(
            date: "2023-02-11T00:00:00+00:00".toDate(),
            items: []
        ),
        .init(
            date: "2023-02-12T00:00:00+00:00".toDate(),
            items: []
        ),
        .init(
            date: "2023-02-13T00:00:00+00:00".toDate(),
            items: []
        ),
        .init(
            date: "2023-02-14T00:00:00+00:00".toDate(),
            items: []
        )
    ]
    
    static var sampleWeekExpenses: [WeekExpense] = [
        .init(
            dateInterval:
                    .init(
                        start: "2023-02-01T00:00:00+00:00".toDate(),
                        end: "2023-02-07T00:00:00+00:00".toDate()
                    ),
            dayExpenses: sampleDayExpenses
        ),
        .init(
            dateInterval:
                    .init(
                        start: "2023-02-08T00:00:00+00:00".toDate(),
                        end: "2023-02-14T00:00:00+00:00".toDate()
                    ),
            dayExpenses: sampleDayExpenses2
        )
    ]
}
