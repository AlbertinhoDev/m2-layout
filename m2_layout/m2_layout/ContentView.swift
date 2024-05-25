
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
                    Picker("Пол", selection: $sex) {
                        Text(Sex.male.rawValue.capitalized).tag(Sex.male)
                        Text(Sex.female.rawValue.capitalized).tag(Sex.female)
                    }
                }
                Section(header: Text("НОТИФИКАЦИЯ")) {
                    Toggle("Получать нотификации", isOn: $isOn)
                        .padding(0)
                        .toggleStyle(.switch)
                    if isOn == true {
                        Text("Новости")
                        Text("Обновления друзей")
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
//        Button ("Мужской", action: {
//            print(sex.rawValue)
//        })
    }
}

#Preview {
    ContentView()
}
