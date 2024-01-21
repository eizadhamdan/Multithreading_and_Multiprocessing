import threading
import concurrent.futures
import time


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
    print("Duration of part 1:", timestamp2 - timestamp1)

    start = time.perf_counter()

    poolingDemo()

    end = time.perf_counter()

    print("Duration of part 2:", end - start)


def func(seconds):
    print("Sleeping for", seconds)
    time.sleep(seconds)
    print("Slept for", seconds, "second(s).")


def poolingDemo():
    with concurrent.futures.ThreadPoolExecutor(max_workers=1) as executor:
        future = executor.submit(func, 3)
        print(future.result())
        future = executor.submit(func, 2)
        print(future.result())


if __name__ == "__main__":
    main()
    