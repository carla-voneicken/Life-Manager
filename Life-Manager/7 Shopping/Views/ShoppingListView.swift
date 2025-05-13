
import SwiftUI


struct ShoppingListView: View {
    @State private var showPopup: Bool = false
    @State private var popupTitle: String = "New Supermarket"
    @State private var newSupermarketTitle: String = ""
    @State private var supermarkets: [Supermarket] = [
        Supermarket(name: "Aldi", color: .red),
        Supermarket(name: "Edeka", color: .yellow),
        Supermarket(name: "Ikea", color: .purple),
        Supermarket(name: "Bauhaus", color: .mint)
    ]
    @State private var selectedSupermarket: Supermarket? // Hier Supermarket beibehalten
    var body: some View {
        let startColor = Color("BackgroundColor")
        let endColor = Color("SeColor")
        NavigationStack {
            VStack {
                HeaderView(showPopup: $showPopup)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(supermarkets) { supermarket in
                            GenericButtonDetailView(data: supermarket, selectedData: $selectedSupermarket)
                        }
                    }
                }
                if let selectedSupermarket = selectedSupermarket {
                    SupermarketDetailView(supermarket: selectedSupermarket)
                }
                Spacer()
            }
            .overlay(
                Group {
                    if showPopup {
                        GenericPopupView(
                            showPopup: $showPopup,
                            titleText: $popupTitle,
                            textFieldText: $newSupermarketTitle,
                            confirmAction: addNewSupermarket,
                            cancelAction: { showPopup = false },
                            popupTitle: "New Supermarket",
                            textFieldPlaceholder: ""
                        )
                        .transition(.scale)
                    }
                }
            )
            .background {
                LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
    func addNewSupermarket() {
        if !newSupermarketTitle.isEmpty {
            let newSupermarket = Supermarket(name: newSupermarketTitle)
            supermarkets.append(newSupermarket)
            newSupermarketTitle = ""
       
        }
        showPopup = false
    }
}
#Preview {
    ShoppingListView()
}
