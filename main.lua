superMatriz = {
    {5,3,4, 6,7,8, 9,1,2}, 
    {6,7,2, 1,9,5, 3,4,8},
    {1,9,8, 3,4,2, 5,6,7}, 
    {8,5,9, 7,6,1, 4,2,3},
    {4,2,6, 8,5,3, 7,9,1}, 
    {7,1,3, 9,2,4, 8,5,6},
    {9,6,1, 5,3,7, 2,8,4}, 
    {2,8,7, 4,1,9, 6,3,5},
    {3,4,5, 2,8,6, 1,7,9}
} 

tabuleiroTeste = {
    {5,3,4, 6,7,8, 9,1,2}, 
    {6,7,2, 1,9,5, 3,4,8},
    {1,9,8, 3,4,2, 5,6,7}, 
    {8,5,9, 7,6,1, 4,2,3},
    {4,2,6, 8,5,3, 7,9,1}, 
    {7,1,3, 9,2,4, 8,5,6},
    {9,6,1, 5,3,7, 2,8,4}, 
    {2,8,7, 4,1,9, 6,3,5},
    {3,4,5, 2,8,6, 1,7,0}
} 

local background = display.newImageRect("background-2.jpg", 1000, 1000)
background.x = display.contentCenterX
background.y = display.contentCenterY

coresTabuleiro = {{1, 0, 1}, {0, 1, 0}}

function verificaMatriz(linha, coluna, superMatriz, numero)

    for i = 1, 9 do
        for j = 1, 9 do
            if (linha == i and coluna == j) then 
                return true 
            end
        end
    end
    return false
end

function newRect(x, y, color)
    rect = display.newRect(x, y, 35, 35)
    rect.fill = color
    return rect
end

function principal()
    vetor = {}
    for i = 1, 9 do
        vetor[i] = {}
        for j = 1, 9 do 
            vetor[i][j] = "" 
        end
    end
    return vetor
end


tabuleiroTela = principal()
textoTela = principal()


function montarTabuleiro()
    posXR, posYR = -15, 50
    for i = 1, 9 do
        for j = 1, 9 do 
            
                local rect = newRect(posXR + 35 * j, posYR)
                rect.id = {i, j}
                rect:setFillColor(0,0,0)
                rect:setStrokeColor(1,1,1)
                rect.strokeWidth = 4
                criarEventoDeToqueRect(rect)

            gameOverBack = display.newImage("back.png", display.contentCenterX, display.contentCenterY)
            gameOverBack:scale(1.5, 1)
            gameOverBack:setFillColor(0.5,0.5,0.5, 0.7)
            gameOverBack.isVisible = false
            
        end
        posYR = posYR + 35
    end
end

function mostraNumeros()
    posXR, posYR = -15, 50
    for i = 1, 9 do
        for j = 1, 9 do

            -- tabuleiroTela[i][j] = tabuleiroTeste[i][j]
            tabuleiroTela[1][1] = superMatriz[i][1]
            tabuleiroTela[1][4] = superMatriz[1][4]
            tabuleiroTela[1][7] = superMatriz[1][7]
            tabuleiroTela[2][2] = superMatriz[2][2]
            tabuleiroTela[2][4] = superMatriz[2][4]
            tabuleiroTela[2][9] = superMatriz[2][9]
            tabuleiroTela[3][3] = superMatriz[3][3]
            tabuleiroTela[4][3] = superMatriz[4][3]
            tabuleiroTela[4][7] = superMatriz[4][7]
            tabuleiroTela[4][9] = superMatriz[4][9]
            tabuleiroTela[5][1] = superMatriz[5][1]
            tabuleiroTela[6][5] = superMatriz[6][5]
            tabuleiroTela[6][8] = superMatriz[6][8]
            tabuleiroTela[7][1] = superMatriz[7][1]
            tabuleiroTela[7][6] = superMatriz[7][6]
            tabuleiroTela[8][2] = superMatriz[8][2]
            tabuleiroTela[8][7] = superMatriz[8][7]
            tabuleiroTela[9][1] = superMatriz[9][1]
            tabuleiroTela[9][4] = superMatriz[9][4]
            tabuleiroTela[9][8] = superMatriz[9][8]
            
            if  verificaNilEVazio(tabuleiroTela) == 81 then
            gameOver()
            end
            
            if (tabuleiroTela[i][j] ~= "") then

                if textoTela[i][j] == "" then   
                    textoTela[i][j] =  display.newText(tabuleiroTela[i][j], posXR + 35 * j, posYR, {fontSize = 60})
                else
                    textoTela[i][j].text = tabuleiroTela[i][j]
                end
            end
            
        end
        posYR = posYR + 35
    end
    print(verificaNilEVazio(tabuleiroTela))
end

function novoJogo()
    tabuleiroTela = principal()
    textoTela = principal()
    montarTabuleiro()
    mostraNumeros()
    gameOverBack.isVisible = false
end


function gameOver()
    gameOverBack.isVisible = true
    gameOver = display.newText("Game over", display.contentCenterX, display.contentCenterY, "Exo2-Medium.ttf", 30)
    gameOver:setFillColor(1, 1, 1)
end 

function checkGameOver()
    contador = 0;
    for i = 1, 9, 1 do
        for j = 1, 9, 1 do
            if(tabuleiroTela[i][j] == 0) then
            contador = contador + 1
            end
        end
    end
    if (contador == 0) then
        return true
    else
        return false
    end
end

num = 0

function linhaColuna(linha, coluna, numero)
    if (verificaMatriz(linha, coluna, superMatriz, num)) then
        tabuleiroTela[linha][coluna] = numero
        print(tabuleiroTela[linha][coluna])
        mostraNumeros()
        return 1
    end
    return 0
end

function selecionarPecaLocal(event)

    if (event.phase == "began") then
        click = event.target.id

        if (tabuleiroTela[click[1]][click[2]] == "") then
            
            num = 1
            tabuleiroTela[click[1]][click[2]] =  num
            linhaColuna(click[1], click[2], num)

        elseif (tabuleiroTela[click[1]][click[2]] > 0 and tabuleiroTela[click[1]][click[2]] < 9) then            
            num = tabuleiroTela[click[1]][click[2]] + 1
            linhaColuna(click[1], click[2], num)

        elseif (tabuleiroTela[click[1]][click[2]] == 9) then
            num = 1
            linhaColuna(click[1], click[2], num)
        end
        verificaNumeroNaSuperMatriz(click[1], click[2], num)
    end
end

function criarEventoDeToqueRect(rect)
    rect:addEventListener("touch", selecionarPecaLocal)
end

montarTabuleiro()

function verificaNumeroNaSuperMatriz(linha, coluna, num)
    local var = false 

    if superMatriz[linha][coluna] == num then
        var = true
        textoTela[linha][coluna]:setFillColor(0,0,1)
        print("CEEEERTOOO")
    end

    if superMatriz[linha][coluna] ~= num then
        textoTela[linha][coluna]:setFillColor(1,0,0)
       var = false
    end

    return var;
end


function verificaNilEVazio(tabuleiroTela)
    local contador = 0
    local decremento = 1;

    for i = 1, 9, 1 do
      for j = 1, 9, 1 do
       if tabuleiroTela[i][j] ~= "" and  tabuleiroTela[i][j] ~= nil then
           contador = contador + 1;
       end
      end
    end
    return contador
end

function mensagem()
    if verificaNilEVazio(tabuleiroTela) == 81 then
        gameOver()
    end
end

local botaoReiniciarJogo = display.newRect(display.contentWidth / 2, display.contentHeight / 2 + 200, 120,40)
botaoReiniciarJogo:setFillColor(253, 253, 150)
botaoReiniciarJogo.id = 11

local textoBotaoReiniciarPosicao = display.newText({text = "Reiniciar Jogo",x = display.contentWidth / 2,y = 440})
textoBotaoReiniciarPosicao:setFillColor(0, 0, 0)

botaoReiniciarJogo:addEventListener("tap", novoJogo)

local templateTextoSudoku = display.newText({text = "SUDOKU",x = display.contentWidth/2,y = -10, fontSize = 40})
templateTextoSudoku:setFillColor(0,0,0)

local numeroCorreto = display.newRect(display.contentWidth /2-145, display.contentHeight / 2 + 130, 20,20)
numeroCorreto:setFillColor(0,0,1)

local numeroCorreto = display.newText({text = " - Número Correto",x = display.contentWidth/2-70,y = 370})
numeroCorreto:setFillColor(0,0,0)

local numeroIncorreto = display.newRect(display.contentWidth /2+15, display.contentHeight / 2 + 130, 20,20)
numeroIncorreto:setFillColor(1,0,0)

local numeroIncorreto = display.newText({text = " - Número Incorreto",x = display.contentWidth/2+90,y = 370})
numeroIncorreto:setFillColor(0,0,0)
