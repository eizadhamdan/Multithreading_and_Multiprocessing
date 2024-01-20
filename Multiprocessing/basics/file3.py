import time
import multiprocessing


def main():
    start = time.perf_counter()

    processes = []

    for _ in range(50):
        p = multiprocessing.Process(target=do_something)
        p.start()
        processes.append(p)

    for process in processes:
        process.join()

    finish = time.perf_counter()

    print(f"Finished in {round(finish - start, 6)} second(s)")


def do_something():
    print("Sleeping for 1 second...")
    print(pow(35, 0.5))         # only to test
    time.sleep(1)
    print(pow(34, 7))           # only to test
    print("Done Sleeping...")


if __name__ == "__main__":
    main()
