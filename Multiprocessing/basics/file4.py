import time
import multiprocessing


def main():
    start = time.perf_counter()

    processes = []

    for _ in range(10):
        p = multiprocessing.Process(target=do_something, args=[1.5])
        p.start()
        processes.append(p)

    for process in processes:
        process.join()

    finish = time.perf_counter()

    print(f"Finished in {round(finish - start, 6)} second(s)")


def do_something(seconds):
    print(f"Sleeping for {seconds} second(s)...")
    time.sleep(seconds)
    print(f"Done Sleeping...{seconds} second(s)")


if __name__ == "__main__":
    main()
