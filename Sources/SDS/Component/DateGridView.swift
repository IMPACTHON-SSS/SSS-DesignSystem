import SwiftUI

@available(iOS 15, macOS 12, *)
public struct DateGridView: View {
    
    let yearAndMonth: Date
    let action: (Int) -> Void
    
    public init(yearAndMonth: Date = Date(),
                action: @escaping (Int) -> Void) {
        self.yearAndMonth = yearAndMonth
        self.action = action
    }
    
    var today: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return Int(dateFormatter.string(from: Date()))!
    }
    
    var arrayOfDays: [[Int]] {
        let calendar = Calendar.current
        
        let month = calendar.component(.month, from: yearAndMonth)
        let year = calendar.component(.year, from: yearAndMonth)
        let firstDayOfMonth = calendar.date(from: DateComponents(year: year, month: month))!
        
        let daysInMonth = calendar.range(of: .day, in: .month, for: firstDayOfMonth)!.count
        let firstWeekdayOfMonth = calendar.component(.weekday, from: firstDayOfMonth)
        
        var calendarDays: [[Int]] = []
        var week: [Int] = Array(repeating: 0, count: firstWeekdayOfMonth - 1)
        
        for day in 1...daysInMonth {
            week.append(day)
            if week.count == 7 {
                calendarDays.append(week)
                week = []
            }
        }
        
        if !week.isEmpty {
            calendarDays.append(week)
        }
        
        let lastArray = Array(repeating: 0, count: 7 - (calendarDays.last?.count ?? 0))
        calendarDays[calendarDays.index(before: calendarDays.endIndex)].append(contentsOf: lastArray)
        return calendarDays
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                let weekdays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
                ForEach(weekdays, id: \.self) { weekday in
                    Text(weekday)
                        .foregroundStyle({ () -> Color in
                            switch weekday {
                            case "SUN": .redColor
                            case "SAT": .blueColor
                            default: .gray4
                            }
                        }())
                        .frame(maxWidth: .infinity)
                }
            }
            .font(.system(size: 13, weight: .semibold))
            VStack(spacing: 7) {
                ForEach(arrayOfDays.indices, id: \.self) { i in
                    HStack(spacing: 5.5) {
                        let week = arrayOfDays[i]
                        ForEach(week.indices, id: \.self) { j in
                            let day = week[j]
                            if day != 0 {
                                Button {
                                    action(day)
                                } label: {
                                    ZStack {
                                        Text("\(day)")
                                            .font(.system(size: 20, weight: .regular))
                                            .foregroundStyle(Color.blackColor)
                                        if day == today {
                                            RoundedRectangle(cornerRadius: 4)
                                                .strokeBorder(Color.accentColor, lineWidth: 2)
                                        }
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .aspectRatio(10/11, contentMode: .fit)
                                }
                                .frame(maxWidth: .infinity)
                            } else {
                                Color.clear
                                    .frame(maxWidth: .infinity)
                                    .aspectRatio(10/11, contentMode: .fit)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct DateGridPreView: View {
    
    var body: some View {
        DateGridView { date in
            print(date)
        }
        .padding()
    }
}

@available(iOS 15, macOS 12, *)
#Preview {
    return DateGridPreView()
}
