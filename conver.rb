https://github.com/troessner/reek.git
Single = ['', 'одна ', 'две ']
Units = ['', 'один ', 'два ', 'три ', 'четыре ', 'пять ', 'шесть ', 'семь ', 
'восемь ', 'девять ']
Decimal = ['десять ', 'одиннадцать ', 'двенадцать ', 'тринадцать ', 'четырнадцать ',
 'пятнадцать ', 'шестьнадцать ', 'семнадцать ', 'восемнадцать ', 'девятнадцать ']
Tens = ['', '', 'двадцать ', 'тридцать ', 'сорок ', 'пятьдесят ', 'шесьтдесят ', 
'семьдесят ', 'восемьдесят ', 'девяносто ']
Hundreds = ['', 'сто ', 'двести ', 'триста ', 'четыреста ', 'пятьсот ', 'шестьсот ', 
'семьсот ', 'восемьсот ', 'девятсот ']
Thousands = ['тысяча ', 'тысячи ', 'тысяч ']
Millions = ['миллион ', 'миллиона ', 'миллионов ']

#преобразование разрядов числа не содержащих родовые признаки
def convert(digit, value) 
    $result = value[$number[-digit].to_i] + $result
end

#преобразование разрядов числа c родовыми признаками  	
def convert_sort(digit, value, kind) 
	case $number[-digit].to_i
	when 0    then $result = value[2] + $result
	when 1    then $result = kind[1] + value[0] + $result
	when 2    then $result = kind[2] + value[1] + $result
	when 3..4 then $result = Units[$number[-digit].to_i] + value[1] + $result
	when 5..9 then $result = Units[$number[-digit].to_i] + value[2] + $result
	end
end

#ввод числа
$number=''
while $number.to_i <=0 || $number.to_i > 1000000000 
  puts "Введите положительное число (не более 9 разрядов)"
  $number = gets.chomp; $result = ''
end

#преобразование единиц, десятичных и десятков
$number[-2].to_i == 1 ? convert(1, Decimal) : convert(1, Units); convert(2, Tens)

#преобразование сотен
convert(3, Hundreds)

#преобразование тысяч, десятичных тысяч и десятков тысяч
if $number[-5].to_i == 1 
  $result = Thousands[2] + $result; convert(4, Decimal)
elsif $number[-4].to_i != 0 || $number[-5].to_i != 0 || $number[-6].to_i != 0 
  convert_sort(4, Thousands, Single); convert(5, Tens)
end
	
#преобразование сотен тысяч
convert(6, Hundreds) 

#преобразование миллионов, десятичних миллионов и десятков миллионов
if $number[-8].to_i == 1 
  $result=Millions[2] + $result; convert(7, Decimal)
elsif $number[-7].to_i != 0 || $number[-8].to_i != 0|| $number[-9].to_i != 0 
  convert_sort(7, Millions, Units); convert(8, Tens)
end

#преобразование сотен миллионов
convert(9, Hundreds)

puts $result
