import SwiftUI

@available(iOS 16, macOS 13, *)
public enum DateGrid {
    
    case image(Int, Image)
    case asyncImage(Int, URL?)
    case red(Int)
    
    var textColor: Color {
        switch self {
        case .image, .asyncImage: .whiteColor
        case .red: .blackColor
        }
    }
}

@available(iOS 16, macOS 13, *)
public struct DateGridView: View {
    
    let yearAndMonth: Date
    let dateGrids: [DateGrid]
    let action: (Int) -> Void
    
    public init(dateGrids: [DateGrid],
                yearAndMonth: Date = Date(),
                action: @escaping (Int) -> Void) {
        self.dateGrids = dateGrids
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
    
    func findGrid(_ with: Int) -> DateGrid? {
        dateGrids.first(where: {
            switch $0 {
            case let .image(day, _): day == with
            case let .asyncImage(day, _): day == with
            case let .red(day): day == with
            }
        })
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
                            let dateGrid = findGrid(day)
                            if day != 0 {
                                Button {
                                    action(day)
                                } label: {
                                    ZStack {
                                        Color.clear
                                            .overlay(
                                                Group {
                                                    switch dateGrid {
                                                    case let .image(_, image):
                                                        image
                                                            .resizable()
                                                            .overlay(Color.black.opacity(0.6))
                                                    case let .asyncImage(_, url):
                                                        AsyncImage(url: url) { image in
                                                            image
                                                                .resizable()
                                                        } placeholder: {
                                                            Color.gray1
                                                        }
                                                        .overlay(Color.black.opacity(0.6))
                                                    case .red(_):
                                                        Color.redColor
                                                    default: EmptyView()
                                                    }
                                                }
                                                    .scaledToFill()
                                            )
                                            .clipShape(RoundedRectangle(cornerRadius: 4))
                                            .aspectRatio(10/11, contentMode: .fill)
                                        Text("\(day)")
                                            .font(day == today
                                                  ? .system(size: 24, weight: .medium)
                                                  : .system(size: 20, weight: .regular))
                                            .foregroundStyle(dateGrid?.textColor ?? Color.black)
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
        DateGridView(dateGrids: [
            .red(1),
            .asyncImage(2, URL(string: "https://nater.com/nater_riding.jpg")),
            .red(4)
        ]) { date in
            print(date)
        }
        .padding()
    }
}

@available(iOS 16, macOS 13, *)
#Preview {
    return DateGridPreView()
}
