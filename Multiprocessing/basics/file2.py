import time
import multiprocessing


def main():
    start = time.perf_counter()

    p1 = multiprocessing.Process(target=do_something)
    p2 = multiprocessing.Process(target=do_something)

    p1.start()
    p2.start()

    p1.join()
    p2.join()

    finish = time.perf_counter()

    print(f"Finished in {round(finish - start, 3)} second(s)")


def do_something():
    print("Sleeping for 1 second...")
    time.sleep(1)
    print("Done Sleeping...")


if __name__ == "__main__":
    main()
