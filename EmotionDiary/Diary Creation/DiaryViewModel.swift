//
//  DiaryViewModel.swift
//  EmotionDiary
//
//  Created by eun-ji on 2023/03/23.
//

import Foundation
import SwiftUI
import Combine


final class DiaryViewModel: ObservableObject{
    
    
    var subscriptions = Set<AnyCancellable>()
    @Published var diaries: Binding<[MoodDiary]>
    @Published var diary: MoodDiary = MoodDiary(date: "", text: "", mood: .great)
    
    @Published var date: Date = Date()
    @Published var isPresented: Binding<Bool> // binding 일때
    @Published var mood: Mood = .great
    @Published var text: String = ""
    
    init(isPresented: Binding<Bool>, diaries: Binding<[MoodDiary]>) {
        self.isPresented = isPresented
        self.diaries = diaries
        
        $date.sink { date in
            print("---> \(date)")
            self.update(date: date)
        }.store(in: &subscriptions)
        
        $mood.sink { mood in
            self.update(mood: mood)
        }.store(in: &subscriptions)
        
        $text.sink { text in
            self.update(text: text)
        }.store(in: &subscriptions)
        
    }
    private func update(text: String){
        self.diary.text = text
    }
    
    
    private func update(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        self.diary.date = formatter.string(from: date)
    }
    
    private func update(mood: Mood) {
        self.diary.mood = mood
    }
    
    func completed() {
        guard diary.date.isEmpty == false else {return}
        print("전체 리스트 추가하기")
        diaries.wrappedValue.append(diary)
        isPresented.wrappedValue = false
    }
    
}
