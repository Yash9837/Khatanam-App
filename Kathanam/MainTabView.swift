import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(Tab.home)

            CoursesView()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Courses")
                }
                .tag(Tab.courses)

            TranslateView()
                .tabItem {
                    Image(systemName: "textformat.size")
                    Text("Translate")
                }
                .tag(Tab.translate)

            ShortsView()
                .tabItem {
                    Image(systemName: "play.rectangle.fill")
                    Text("Shorts")
                }
                .tag(Tab.shorts)

            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(Tab.profile)
        }
        .accentColor(.orange) // Highlighted tab color
    }
}

// MARK: - Tab Enum
enum Tab: CaseIterable  {
    case home, courses, translate, shorts, profile
}

#Preview {
    MainTabView()
}

