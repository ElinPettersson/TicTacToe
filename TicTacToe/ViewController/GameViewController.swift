//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Elin Pettersson on 2022-09-19.
//

import UIKit

class GameViewController: UIViewController {
    
    
    let GAME_CONTINUE = 0
    let RESULT_PLAYER1 = 1
    let RESULT_PLAYER2 = 2
    
    @IBOutlet weak var gamePiece: UIImageView!
    @IBOutlet var gameBoxes: [UIImageView]!
    
    
    @IBOutlet weak var lblPlayer: UILabel!
    
    @IBOutlet weak var horizontalPieceConstraint: NSLayoutConstraint!
    @IBOutlet weak var verticalPieceConstraint: NSLayoutConstraint!
    
    var gameActive: Bool = false
    
    var player: Int = 0
    
    var board: Array = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startGame()

    }
    
    func startGame() {
        gameActive = true
        if player == 0 {
            player = 1
            gamePiece.image = UIImage.init(named: "Donut")
            lblPlayer.text = "Player \(player) make your move!"
        }
        
    }
    
    func changePlayer() {
        
        if gameActive == true {
            
        if player == 1 {
            gamePiece.image = UIImage.init(named: "Cross")
            player = 2
            lblPlayer.text = "Player \(player) make your move!"
        } else {
            gamePiece.image = UIImage.init(named: "Donut")
            player = 1
            lblPlayer.text = "Player \(player) make your move!"
        }
    }
    }
    
    func checkWin() -> Int {
        
        if board[0] == board[1] && board[0] == board[2] && board[0] != 0 {
            gameActive = false
            return board[0]
        }
        if board[3] == board[4] && board[3] == board[5] && board[3] != 0 {
            gameActive = false
            return board[3]
        }
        if board[6] == board[7] && board[6] == board[8] && board[6] != 0 {
            gameActive = false
            return board[6]
        }
        
        if board[0] == board[3] && board[0] == board[6] && board[0] != 0 {
            gameActive = false
            return board[0]
        }
        if board[1] == board[4] && board[1] == board[7] && board[1] != 0 {
            gameActive = false
            return board[1]
        }
        if board[2] == board[5] && board[2] == board[8] && board[2] != 0 {
            gameActive = false
            return board[2]
        }
        
        if board[0] == board[4] && board[0] == board[8] && board[0] != 0 {
            gameActive = false
            return board[0]
        }
        if board[2] == board[4] && board[2] == board[6] && board[2] != 0 {
            gameActive = false
            return board[2]
        }
        
        return GAME_CONTINUE
        
    }
    
    
    func addMove(index: Int) {
        
        if gameActive != true {
            return
        }
        
        if board[index] != 0 {
            return
        }
    
        board[index] = player
        
        print(board)
        
        let result = checkWin()
        
        if result != GAME_CONTINUE {
            
            print("Player \(result) has won!")
            lblPlayer.text = "Player \(result) has won!"
            gameActive = false
            return
        }
        
        
        var count = 0
        
        for cell in board {
            if cell != 0 {
                count += 1
            }
        }
        
        if count > 8 {
            gameActive = false
            lblPlayer.text = "Its a draw!"
            print("We have a draw")
            return
        }
        
    }
    
    @IBAction func startOver(_ sender: Any) {
        board = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        player = 0
        gameActive = true
        startGame()
        
        for gameBox in gameBoxes {
            gameBox.image = UIImage(systemName: "squareshape.fill")
        }
    }
    
    
    @IBAction func onDrag(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: self.view)

        guard sender.view != nil else {return}
        
        if gameActive == true {
            
            if sender.state != .ended {
                
                horizontalPieceConstraint.constant = horizontalPieceConstraint.constant + translation.x
                verticalPieceConstraint.constant = verticalPieceConstraint.constant - translation.y
    
            } else {
                
                let imageName = player == 1 ? "Donut" : "Cross"
                
                for gameBox in gameBoxes {
                    if gameBox.image == UIImage(systemName: "squareshape.fill") {
                    if gameBox.frame.contains(gamePiece.frame) {
                        gameBox.image = UIImage.init(named: imageName)
                        addMove(index: gameBox.tag)
                        changePlayer()
                    }
                    }
                }
                
                horizontalPieceConstraint.constant = 0
                verticalPieceConstraint.constant = 80
            
            }

        sender.setTranslation(CGPoint.zero, in: self.view)
        
        }
        
    }
    
}
