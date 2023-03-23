//
//  DiaryDetailsViewModel.swift
//  EmotionDiary
//
//  Created by eun-ji on 2023/03/23.
//

import Foundation
import SwiftUI

final class DiaryDetailsViewModel : ObservableObject {
    @Published var diaries: Binding<[MoodDiary]>
    @Published var diary: MoodDiary
    
    init(diarise: Binding<[MoodDiary]>, diary: MoodDiary) {
        self.diaries = diarise
        self.diary = diary
    }
    
    func delete() {
        diaries.wrappedValue = diaries.wrappedValue.filter{$0.id != diary.id}
    }
}

