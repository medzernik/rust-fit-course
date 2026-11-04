#include <thread>
#include <iostream>

int v = 0;

void count(int *delta) {
    // add delta to v 100 000 times
    for (int i = 0; i < 100000; i++) {
        v += *delta;
    }
}

int main() {
    int delta1 = 1;
    int delta2 = -1;

    auto thread1 = std::thread([&delta1]() {
        count(&delta1);
    });
    auto thread2 = std::thread([&delta2]() {
        count(&delta2);
    });

    thread1.join();
    thread2.join();

    std::cout << v << std::endl;
}
