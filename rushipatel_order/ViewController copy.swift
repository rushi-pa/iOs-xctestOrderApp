import UIKit
var neworders = order.getInitialData()
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var coopick : UIPickerView!
    @IBOutlet weak var colv : UICollectionView!
    var cofeeCovers = [UIImage]();
    var yourArray = [String](arrayLiteral: "Dark Roast","Dalgona", "Cappucino" , "Irish Creme","Cold Brew", "Or just an espresso would do")
   
    var colors = [UIColor](arrayLiteral: UIColor.red, UIColor.blue,  UIColor.green, UIColor.yellow, UIColor.orange ,UIColor.purple);
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cofeeCovers.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colv.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainCell
        cell.image.image = self.cofeeCovers[indexPath.row]
        cell.bgcol.backgroundColor = self.colors[indexPath.row].withAlphaComponent(0.45);
        cell.tit.text = self.yourArray[indexPath.row];
        cell.image.layer.cornerRadius = 10.0;
        cell.bgcol.layer.cornerRadius = 10.0;
        cell.image.layer.masksToBounds = true;
        cell.bgcol.layer.masksToBounds = true;
        return cell;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colv.dataSource = self;
        colv.delegate = self;
        for image in 1...6 {
            let coffe = UIImage(named: "image\(image).jpg");
            self.cofeeCovers.append(coffe!);
            
        }
        self.colv.layer.cornerRadius = 2.0
        self.colv.layer.borderWidth = 1.0
        self.colv.layer.borderColor = UIColor.clear.cgColor
        self.colv.layer.masksToBounds = true
        
        
        
        
        //picker view data
        self.coopick.delegate = self
             self.coopick.dataSource = self
    }


    
    var test :String = "Dark Roast"
    
    //Picker view details
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return yourArray.count;
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return yourArray[row]
    }
    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.test = yourArray[row];
        print(test)
    }
    
    
    
    
    var size :String = "Tall"
    //Segmented control details
    @IBAction func segmentchange(sender: UISegmentedControl){
        print ("index: ", sender.selectedSegmentIndex)

        if sender.selectedSegmentIndex == 0 {
            size = "Tall"
        }
        if sender.selectedSegmentIndex == 1 {
            size = "Grande"
        }
        if sender.selectedSegmentIndex == 2 {
            size = "Venti"
        }
    }
    
    
    
    //Number of coffee
    @IBOutlet weak var noOfCoffee : UITextField!
    
    
    //Special Instructions
    @IBOutlet weak var spec : UITextField!
    
    
    //BUTOON SPECS
    //var neworders = [order]();
   

    @IBAction func placeorder(){
        if (!self.noOfCoffee.text!.isEmpty){
        print("order place selected");
       
            neworders.append(order(name : test ,  size : self.size , noOf: noOfCoffee.text ?? "" , instruction: spec.text ?? ""));
            print(neworders);
            
        } else{
            //show error
            self.showErrorAlert(errorMessage: "None of the inputs can be empty")
        }
    }

func showErrorAlert(errorMessage : String){
    let errorAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
    errorAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
    self.present(errorAlert, animated: true, completion: nil)
}
    
    //Button cancel specs
    @IBAction func cancel(){
        print("order canceled");
    }
    
    
    
    
    //bus backchodi
    
    
 
}
