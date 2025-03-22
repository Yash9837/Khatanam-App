//
//  ProfileView.swift
//  Kathanam
//
//  Created by Yash's Mackbook on 26/02/25.
//
import SwiftUI
import Charts

struct ProfileView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // ✅ Full Orange Gradient Background
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange, Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        // ✅ Header Section (Title & User Profile)
                        headerSection()
                        
                        // ✅ Dashboard Stats
                        statsSection()
                        
//                        // ✅ Popular Courses
//                        popularCoursesSection()
//                        
                        // ✅ My Courses Table
                        myCoursesSection()
                        
                        VStack( spacing: 15) {
                            // ✅ Course Topics Pie Chart
                            courseTopicChart()
                            
                            // ✅ Continue Learning Progress
                            continueLearningSection()
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 50)
                }
            }}
    }

    // MARK: - Header Section (Title & User Profile)
    func headerSection() -> some View {
        HStack {
            Text("Dashboard")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)

            Spacer()

            HStack(spacing: 15) {
                Image(systemName: "bell.badge.fill")
                    .font(.title2)
                    .foregroundColor(.black)

                Image("autistic") // Replace with actual user image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .shadow(radius: 3)
            }
        }
        .padding(.horizontal)
    }

    // MARK: - Dashboard Stats (Ongoing, Completed, Certificates, Hours)
    func statsSection() -> some View {
        HStack(spacing: 0){
            VStack(spacing: 10) {
                statsCard(icon: "square.grid.2x2.fill", title: "Ongoing", value: "5", color: .blue)
                statsCard(icon: "checkmark.circle.fill", title: "Completed", value: "37", color: .green)
            }
            .padding(.horizontal)
            VStack(spacing: 10) {
                statsCard(icon: "doc.fill", title: "Certificate", value: "25", color: .orange)
                statsCard(icon: "clock.fill", title: "Hours Done", value: "705", color: .purple)
            }
            .padding(.horizontal)
        }}

    func statsCard(icon: String, title: String, value: String, color: Color) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)

            Text(value)
                .font(.title2)
                .bold()
                .foregroundColor(.black)

            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 3)
    }

    // MARK: - Popular Courses Section
    func popularCoursesSection() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Popular Courses")
                    .font(.headline)
                    .bold()
                
                Spacer()
                
                Button("View All") {}
                    .foregroundColor(.blue)
            }
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    courseCard(title: "Create 3D with Blender", category: "Design", lessons: "16 Lessons • 48 Hours", price: "$400", imageName: "blender_course")
                    courseCard(title: "Digital Marketing", category: "Business", lessons: "30 Lessons • 48 Hours", price: "$100", imageName: "marketing_course")
                    courseCard(title: "UI Design with Tailwind", category: "Code", lessons: "30 Lessons • 48 Hours", price: "$100", imageName: "tailwind_course")
                }
                .padding(.horizontal)
            }
        }
    }

    func courseCard(title: String, category: String, lessons: String, price: String, imageName: String) -> some View {
        VStack(alignment: .leading) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .cornerRadius(10)

            Text(category.uppercased())
                .font(.caption)
                .bold()
                .foregroundColor(.gray)

            Text(title)
                .font(.headline)
                .foregroundColor(.black)

            Text(lessons)
                .font(.caption)
                .foregroundColor(.gray)

            Text(price)
                .font(.headline)
                .foregroundColor(.red)
        }
        .frame(width: 200)
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 3)
    }

    // MARK: - My Courses Table
    func myCoursesSection() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("My Courses")
                .font(.headline)
                .bold()
                .padding(.horizontal)

            VStack {
                myCourseRow(title: "ASL", lessons: "15/15", status: "Complete", level: "Intermediate")
                myCourseRow(title: "ISL", lessons: "12/15", status: "Ongoing", level: "Beginner")
                myCourseRow(title: "Autistic", lessons: "8/20", status: "Ongoing", level: "Expert")
            }
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 3)
            .padding(.horizontal)
        }
    }

    func myCourseRow(title: String, lessons: String, status: String, level: String) -> some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .bold()

            Spacer()

            Text(lessons)
                .foregroundColor(.gray)

            Text(status)
                .foregroundColor(status == "Complete" ? .green : .blue)

            Text(level)
                .foregroundColor(.gray)
        }
        .padding()
    }

    // MARK: - Course Topic Pie Chart
    func courseTopicChart() -> some View {
        HStack(spacing: 100) {

            ZStack {
                Circle()
                    .trim(from: 0.0, to: 0.42)
                    .stroke(Color.purple, lineWidth: 12)
                    .rotationEffect(.degrees(-90))

                Text("42 Total Courses")
                    .font(.headline)
            }
            .frame(width: 120, height: 120)

            topicLegend()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 3)
    }

    func topicLegend() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            legendRow(color: .purple, text: "ISL (40%)")
            legendRow(color: .blue, text: "ASL (30%)")
            legendRow(color: .orange, text: "Autistic (20%)")
        }
    }

    func legendRow(color: Color, text: String) -> some View {
        HStack {
            Circle().fill(color).frame(width: 10, height: 10)
            Text(text)
        }
        .font(.caption)
    }

    // MARK: - Continue Learning Section
    func continueLearningSection() -> some View {
        VStack {
            Text("Continue Learning")
                .font(.headline)
                .bold()
            

            continueLearningCard(title: "Sign Basics", progress: 75)
            continueLearningCard(title: "Cultural Expressions", progress: 60)
            continueLearningCard(title: "Social Interaction", progress: 40)
        }
    }

    func continueLearningCard(title: String, progress: Double) -> some View {
        HStack {
            Text(title)
                .font(.subheadline)

            Spacer()

            ProgressView(value: progress, total: 100)
                .frame(width: 100)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 3)
    }
}

#Preview {
    ProfileView()
}
