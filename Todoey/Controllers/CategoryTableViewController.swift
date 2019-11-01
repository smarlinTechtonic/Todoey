import UIKit
import RealmSwift
import ChameleonFramework

// Inherits from SwipeTableViewCOntroller
class CategoryTableViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    var categories: Results<CategoryList>?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        tableView.separatorStyle = .none
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "There are no categories"
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].color ?? "#fff")
        cell.textLabel?.textColor = ContrastColorOf(cell.backgroundColor!, returnFlat: true)
        return cell
        
    }
    
    //MARK: - Add more categories
    @IBAction func addCategoryButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Category", message: "Add a new to-do Category here", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let newCategory = CategoryList()
            let color = UIColor.randomFlat().hexValue()
            newCategory.name = textField.text!
            newCategory.color = color
            self.saveCategories(category: newCategory)
        }
        alert.addAction(alertAction)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new to-do item"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
        
    }
    
    func loadCategories() {
        
        categories = realm.objects(CategoryList.self)
        tableView.reloadData()
        
    }
    
    func saveCategories(category: CategoryList) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("There was an error saving category context: \(error)")
        }
        tableView.reloadData()
        
    }
    
    // MARK: - Override deleteModel of superclass
    override func deleteModel(at indexPath: IndexPath) {
        if let categoryToDelete = categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryToDelete)
                }
            } catch {
                print("There was an error \(error)")
            }
        }
    }
    
    // MARK: - Table view data delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //MARK: Delete Data Method
}
