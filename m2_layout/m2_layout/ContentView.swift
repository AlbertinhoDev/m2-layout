import SwiftUI

struct ContentView: View {
    
    @State private var firstName = ""
    @State private var secondName = ""
    @State private var dateBirth = Date()
    @State private var sex: Sex = .male
    @State private var isOn = false
    @State private var title = "Выход"
    @State private var informText = "Вы уверены, что хотите выйти?"
    @State private var isShowingDialog = false
    @State private var showNewsToggle = false
    @State private var showFriendsUpdatesToggle = false
    
    enum Sex: String, CaseIterable, Identifiable {
        var id: Self {self}
        
        case male = "Мужской" ,
             female = "Женский"
        
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("ЛИЧНЫЕ ДАННЫЕ")) {
                    TextField("ИМЯ", text: $firstName)
                    TextField("ФАМИЛИЯ", text: $secondName)
                    DatePicker("Дата рождения", selection: $dateBirth, displayedComponents: [.date])
                    NavigationLink(destination: SexSelectionView(selectedSex: $sex)) {
                        Text("Пол: \(sex.rawValue)")
                    }
                }
                
                Section(header: Text("НОТИФИКАЦИИ")) {

                    Toggle("Получать нотификации", isOn: $isOn)

                    if isOn {

                        Toggle("Новости", isOn: $showNewsToggle)

                        Toggle("Обновления друзей", isOn: $showFriendsUpdatesToggle)

                    }

                }

                Section(header: Text("Документы")) {
                    Button ("Личные данные", action: {
                        
                    })
                    
                    Button ("Условия использования", action: {
                        
                    })
                }
                Section(){
                    Button ("Выход", action: {
                        isShowingDialog = true
                    })
                    .foregroundColor(.red)
                    .alert(isPresented: $isShowingDialog) {
                        return Alert(title: Text(title),
                                     message: Text(informText), primaryButton: .destructive(Text("Выйти"), action: {exit(0)}), secondaryButton: .cancel())

                    }
                    
                }
            }
            .padding(0)
        }

    }
}

struct SexSelectionView: View {
    
    @Binding var selectedSex: ContentView.Sex
    
    var body: some View {
        List(ContentView.Sex.allCases) { sex in
            Button(action: {
                selectedSex = sex
            }) {
                Text(sex.rawValue)
                    .foregroundColor(selectedSex == sex ? .blue : .primary)
            }
        }
        .navigationBarTitle("Выберите пол")
    }
    
    
}

#Preview {
    ContentView()
}
