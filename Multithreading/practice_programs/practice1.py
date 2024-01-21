import threading
import time


def func(seconds):
    print("Sleeping for", seconds)
    time.sleep(seconds)
    print("Slept for", seconds, "second(s).")


def main():
    timestamp1 = time.perf_counter()

    t1 = threading.Thread(target=func, args=[4])
    t2 = threading.Thread(target=func, args=[2])
    t3 = threading.Thread(target=func, args=[1])

    t1.start()
    t2.start()
    t3.start()

    t1.join()
    t2.join()
    t3.join()

    timestamp2 = time.perf_counter()

    # calculating time of execution of the program
    print("Duration of program:", timestamp2 - timestamp1)


if __name__ == "__main__":
    main()
