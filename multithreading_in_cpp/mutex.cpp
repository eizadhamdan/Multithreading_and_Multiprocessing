#include <iostream>
#include <thread>


void function1(char);
void function2();

int main()
{
    std::thread worker1(function1, '+');
    std::thread worker2(function2);

    std::cin.get();
}

void function1(char symbol)
{
    for (int i = 0; i < 200; i++)
    {
        std::cout << symbol;
    }
}

void function2()
{
    for (int i = 0; i < 200; i++)
    {
    std:: cout << "-";
    }
}