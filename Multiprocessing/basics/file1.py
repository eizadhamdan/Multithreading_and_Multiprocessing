import time


def main():
    start = time.perf_counter()
    do_something()
    do_something()

    finish = time.perf_counter()

    print(f"Finished in {round(finish - start, 3)} second(s)")


def do_something():
    print("Sleeping for 1 second...")
    time.sleep(1)
    print("Done Sleeping...")


if __name__ == "__main__":
    main()
