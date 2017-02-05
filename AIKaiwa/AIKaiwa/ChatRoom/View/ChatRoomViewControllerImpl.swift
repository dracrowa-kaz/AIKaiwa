//
//  ChatRoomViewController.swift
//  Kuri
//
//  Created by kaz on 2017/2/3.
//  Copyright © 2016年 kaz. All rights reserved.
//

import UIKit
import SCLAlertView

class ChatRoomViewController: UIViewController {
    
    fileprivate var presenter: ChatRoomPresenter!
    fileprivate var model : ChatRoomModel?
    
    @IBOutlet weak var chatHistoryTableView: UITableView!
    @IBOutlet weak var chatTextField: UITextField!
    
    func inject(
        presenter: ChatRoomPresenter
        ) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SCLAlertView().showInfo("Tutorial", subTitle: "下のチャットボックスに入力して、sendボタンを押してください")
        self.chatRefresh()
        setting()
    }
    
    @IBAction func sendBtnTapped(_ sender: UIBarButtonItem) {
        textFieldCompleteButtonTapped()
        print(presenter.sendText(text: chatTextField.text!))
        chatTextField.text = ""
    }
    
    //Call after chatRefresh method
    private func setting(){
        self.navigationItem.title = "AIチャット"
        chatTextField.inputAccessoryView = createCompleteBtnForTextField()
        chatTextField.delegate = self
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.handleKeyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.handleKeyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        chatHistoryTableView.delegate = self
        chatHistoryTableView.dataSource = self
        chatHistoryTableView.estimatedRowHeight = 20
        chatHistoryTableView.rowHeight = UITableViewAutomaticDimension
    }
}

//Protocol method
extension ChatRoomViewController : ChatRoomViewControllerOutput {

    func chatRefresh(){
        //If model was null , then app don't read chat history anymore.
        //TODO: Show error message here
        guard let resultModel = presenter.getChatHistory() else {
            print("Model is null")
            return
        }
        self.model = resultModel
        self.chatHistoryTableView.reloadData()
        /*self.chatHistoryTableView.setContentOffset(
            CGPoint(x: 0, y: chatHistoryTableView.contentSize.height),
            animated: true)*/
    }
}

//TableView delegate
extension ChatRoomViewController: UITableViewDelegate , UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (model?.chatRoomContentModelArray.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let contentModel = model?.chatRoomContentModelArray[indexPath.row] else {
            return UITableViewCell()
        }
        //Switch user and robot cell
        let nibname = contentModel.person == .robot ? "ChatHistoryTableViewCell" : "ChatUserTableViewCell"
        let cell = UINib(nibName: nibname , bundle: nil).instantiate(withOwner: self, options: nil)[0] as! ChatHistoryTableViewCell
        cell.setupCell(model: contentModel, isShowDate: false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("tapped")
    }
}

//Text field delegate
extension ChatRoomViewController{
    func createCompleteBtnForTextField()->UIToolbar{
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        toolBar.barStyle = UIBarStyle.default
        toolBar.sizeToFit()
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.textFieldCompleteButtonTapped))
        toolBar.items = [spacer, commitButton]
        return toolBar
    }
    
    func textFieldCompleteButtonTapped(){
        self.view.endEditing(true)
    }
}

extension ChatRoomViewController: UITextFieldDelegate {
    func handleKeyboardWillShowNotification(_ notification: NSNotification) {
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let myBoundSize: CGSize = UIScreen.main.bounds.size
        let txtLimit = chatTextField.frame.origin.y + chatTextField.frame.height + 300.0
        let kbdLimit = myBoundSize.height - keyboardScreenEndFrame.size.height
        if txtLimit >= kbdLimit && self.view.frame.minY == 0{
            self.view.frame = CGRect(x: 0, y: -kbdLimit + 10, width: self.view.frame.width, height: self.view.frame.height)
        }
    }
    
    func handleKeyboardWillHideNotification(_ notification: NSNotification) {
        self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
    }
}
