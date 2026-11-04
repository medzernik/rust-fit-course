#include <mutex>
#include <thread>

void forgotten_lock() {
    int data = 0;
    std::mutex mutex;

    std::thread thread = std::thread([&data, &mutex]() {
        mutex.lock();
        data++;
        mutex.unlock();
    });

    data++; // Oops

    thread.join();
}

void forgotten_unlock() {
    int data = 0;
    std::mutex mutex;

    std::thread thread = std::thread([&data, &mutex]() {
        while (true) {
            mutex.lock();
            data++;
            if (data > 10) break;
            mutex.unlock(); // Oops
        }
    });

    {
        mutex.lock();
        data++;
        mutex.unlock();
    }

    thread.join();
}

void dropped_mutex() {
    int data = 0;
    std::mutex mutex;

    std::thread thread = std::thread([&data, &mutex]() {
        while (true) {
            std::lock_guard guard(mutex);
            data++;
        }
    });
    thread.detach();
}

int main() {
    forgotten_lock();
    forgotten_unlock();
    dropped_mutex();

    return 0;
}
