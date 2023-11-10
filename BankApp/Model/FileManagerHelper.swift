
import Foundation

class FileManagerHelper{
    
    func getFilePath() -> URL {
        let files = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let path = files[0].appendingPathComponent("users.json")
        print(path)
        return path
    }
    
    func writeData(users: [User]){
        do{
            let data = try JSONEncoder().encode(users)
            try data.write(to: getFilePath())
            
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func readData (complete: (([User]) -> Void)) {
        if let data = try? Data(contentsOf: getFilePath()){
            do {
                let items = try JSONDecoder().decode([User].self, from: data)
                complete(items)
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    func saveData(users: [User], completion: @escaping (Bool) -> Void) {
            writeData(users: users)
            completion(true)
        }
    
}
