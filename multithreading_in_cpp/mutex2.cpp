#include <iostream>
#include <thread>
#include <chrono>
#include <string>
#include <mutex>

std::mutex carMutex;

void driveCar(std::string driverName)
{
    //locking the critical section
    std::unique_lock<std::mutex> carLock(carMutex);
    
    using namespace std::chrono_literals;

    std::cout << driverName << " is driving." << std::endl;
    std::this_thread::sleep_for(2000ms);
    std::cout << driverName << " is done driving." << std::endl;

    carLock.unlock();
}

int main()
{
    std::thread t1(driveCar, "Eizad");
    std::thread t2(driveCar, "Hamdan");



    //this is to make sure that both of these threads have finished their work
    t1.join();
    t2.join();


    std::cin.get();
}