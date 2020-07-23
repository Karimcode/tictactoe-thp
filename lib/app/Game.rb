class Game

  attr_accessor :symbol

  def initialize
    # On efface l'écran du terminal
    system "clear"
    puts "Bienvenue au jeu du morpion de THP!
    \n Attention, si tu choisis une case déjà occupée, tu perds ton tour!
    \n Joueur 1, tu auras les X, comment t'appelles-tu ? "
    print ">"
    name_player1 = gets.chomp

    # Création du joueur 1
    @player1 = Player.new(name_player1, "X")
    puts
    puts "Joueur 2, tu auras les O, comment t'appelles-tu ? "
    print ">"
    name_player2 = gets.chomp

    # Création du joueur 2
    @player2 = Player.new(name_player2, "O")
    @current_player = @player1

    # Création du plateau de jeu
    @board = Board.new
  end

  def begin
    # lance la partie
    while @board.victory? == false
      self.game_step
    # En cas de match nul la partie s'arrête
      if @board.draw? == true && @board.victory? == false
        puts "Match nul"
      end
   end
  end

  # Passe d'un joueur à l'autre
  def switch_players
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end

  def game_step
    # On boucle tant qu'il n'y a pas de victoire

    loop do
      system "clear"
      puts "============="

      puts "Voici l'état du jeu:"
      # Affiche le plateau :
      @board.display

      puts ""
      puts "C'est le tour de #{@current_player.name} avec les #{@current_player.symbol}"
      puts "Choisis une case"
      print ">"
      if (@board.draw? == true && @board.victory? == false)
        system "clear"
        puts "============="
        puts "Voici l'état du jeu:"

           puts "Match nul !
           "
      end
      # On appelle la méthode play de la classe board sur le joueur en cours (current). Elle demande au joueur quelle case il joue, puis affiche son symbole dans la case
      @board.play(@current_player.symbol)

      # On arrête la boucle en cas de victoire
      if (@board.victory? == true)
        # binding.pry
        system "clear"
        puts "============="
        puts "Voici l'état du jeu:"
        @board.display
        puts ""
        puts "#{@current_player.name} a gagné !!!"
        puts
        break

      # Il n'y a pas de victoire : on passe au joueur suivant et on boucle (tour suivant)
      else
        switch_players
      end
    end
  end



end

###############################

class Player
  # La classe a deux attr_accessor : son nom, et son symbole (X ou O).
  attr_accessor :name, :symbol

  def initialize(name, symbol)
    # Nom du joueur, et symbole affiché par son jeu
    @name = name
    @symbol = symbol
  end

end

###############################

# Tableau de jeu
class Board

  attr_accessor :board

  def initialize
    #Quand la classe s'initialize, elle crée 9 instances BoardCases
    #Ces instances sont rangées dans une array qui est l'attr_accessor de la classe => la valeur est croissante de 0 à 8
    @board =  [*0..8].map { |i|  BoardCase.new(i).case_number }
  end


  def display
  # affiche le plateau
    puts "#{@board[0..2].join(" | ")}"
    puts "--|---|--"
    puts "#{@board[3..5].join(" | ")}"
    puts "--|---|--"
    puts "#{@board[6..8].join(" | ")}"
  end

  def play(symbol)
    # change la case jouée en fonction de ce qu'a joué le joueur (X, ou O)
    case_number = gets.chomp().to_i
    # “For each index of @board array, if @board[e] doesn’t equal to X and @board[e] doesn’t equal to O then assign symbol to it, otherwise just return @board[e]”
    @board = @board.each_index.map { |e| e == case_number && @board[e] != "X" && @board[e] != "O" ? @board[e] = symbol : @board[e] }
  end

  def victory?
    # On teste si les rangées ou diagonales contiennent des symboles identiques
    if (@board[0] == @board[1] && @board[0] == @board[2]) || (@board[3] == @board[4] && @board[3] == @board[5]) || (@board[6] == @board[7] && @board[6] == @board[8] ) || (@board[0] == @board[3] && @board[0] == @board[6]) || (@board[1] == @board[4] && @board[1] == @board[7]) || (@board[2] == @board[5] && @board[2] == @board[8]) ||( @board[0] == @board[4] && @board[0] == @board[8]) || (@board[2] == @board[4] && @board[2] == @board[6])
      return true
    else
      return false
    end
  end

  def draw?
# Si il y a 5 "X" ou 5 "O" il y a match nul
    if (@board.count("X") == 5 or @board.count("O") == 5)
      return true
    else
      return false
    end
  end
end

###############################

class BoardCase
  #la classe a deux attr_accessor : sa valeur ("X", "O", ou vide), et son numéro de case.
  attr_accessor :value, :case_number

  def initialize(case_number)
    @value = ""
    @case_number = case_number
  end


  def transform_to_string
    # renvoie la valeur au format string
    self.value = @value
  end

end





