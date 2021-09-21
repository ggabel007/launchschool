# capture 1) loan amount, 2) APR, and 3) length of loan
# calculate -
# =>  1) monthly interest rate,
# =>  2) loan duration in months
# =>  3) monthly payment
# formula is monthly_payment = loan amount #(monthly_interest_rate / (1 - (1 + montly_interest_rate) **(-loan_duration_in_months)))
# run through rubocop
require 'yaml'
MESSAGES = YAML.load_file('mort_messages.yml')

def prompt(message)
  puts "==> #{message}"
end

def valid_number?(num)
  num.to_i != 0
end

def integer?(num)
  num.to_i.to_s == num
end

def float?(num)
  num.to_f.to_s == num
end

name = ''
prompt(MESSAGES['welcome'])
loop do
  name = gets.chomp
  if name.empty?
    prompt(MESSAGES['valid_name'])
  else
    break
  end
end

loan = ''
puts "#{name}, how much is the loan? "
loop do
  loan = gets.chomp
  if valid_number?(loan) && integer?(loan)
    break
  else
    prompt(MESSAGES['valid_number'])
  end
end

apr = ''
prompt("#{name}, how much is the Annual Percentage Rate (APR)? ")
loop do
  apr = gets.chomp
  if valid_number?(apr) && float?(apr) || integer?(apr)
    break
  else
    prompt(MESSAGES['valid_number'])
  end
end

loan_years = ''
loan_months = ''
prompt("#{name}, how many years are you taking out a mortgage? ")
loop do
  loan_years = gets.chomp
  if valid_number?(loan_years) && integer?(loan_years)
    loan_months = loan_years.to_i * 12
    break
  else
    prompt(MESSAGES['valid_number'])
  end
end

# calculates from annual APR to montly interest
monthly_interest_rate = (apr.to_f * 0.01) / 12
prompt("If your monthly interest rate is #{monthly_interest_rate}%...")
# uses the monthly payment formula to calculate payment amount
monthly_payment = loan.to_f * (monthly_interest_rate.to_f / (1 - (1 + monthly_interest_rate.to_f)**(-loan_months.to_i)))
# outputs information from the equation
prompt("Your monthly payment over #{loan_months} months is:  $#{monthly_payment.floor(2)}")
prompt("DISCLAIMER: Mortgage expense does not include taxes or insurance.")
