def split(array)
    cnt=0
    array2 = []
    array.each{ | i |
        array2[cnt] = i.split(".")
        cnt += 1
    }
    array2 = lShift(array2)
    return array2
end

def lShift(num)
    for cnt in 0..1 do
        #intへ
        num[cnt].map!(&:to_i)
        #シフト演算
        i = 24
        cnt2 = 0
        while i >= 0 do
            num[cnt][cnt2] = num[cnt][cnt2] << i
            cnt2+=1
            i -= 8
        end        
    end
    return num
end

def rShift(num)
    for n in 0..3 do
        i=24
        res = []
        for cnt in 0..3 do
            res[cnt] = ((num[n] >> i) & 255)
            i-=8
        end
        num[n] = res.join('.')
    end
    return num
end

def procces
    #入力処理
    puts 'サーバIP'
    surver = gets
    puts 'クライアントIP'
    client = gets
    #値の分割
    sArray = split(surver.split)
    cArray = split(client.split)
    #配列統合
    for cnt in 0..1 do
        sArray[cnt] = sArray[cnt].sum
        cArray[cnt] = cArray[cnt].sum
    end
    #サーバ視点の参照
    resultArray = [(sArray[0] & sArray[1]),(cArray[0] & sArray[1]),(sArray[0] & cArray[1]),(cArray[0] & cArray[1])]
    #比較
    s = ""
    t = ""
    if sArray[0]==cArray[0] then
        s =  "\e[41m"
        t =  "\e[0m"
    else
        if (resultArray[0] != resultArray[1])||(resultArray[2] != resultArray[3]) then
            s = "\e[31m"
            t =  "\e[0m"
        end
    end
    #シフトクラスへ
    resultArray = rShift(resultArray)
    re=[s,t,resultArray[0],resultArray[1],resultArray[2],resultArray[3]]
    return re
end

def main
    result = procces
    #表示
    p "サーバー視点"
    puts "サーバーNetAddr:　　" + result[0] + result[2] + result[1]
    puts "クライアントNetAddr:" + result[0] + result[3] + result[1]
    p "クライアント視点"
    puts "サーバーNetAddr:　　" + result[0] + result[4] + result[1]
    puts "クライアントNetAddr:" + result[0] + result[5] + result[1]
end

main