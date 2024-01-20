import time
import concurrent.futures


def main():
    start = time.perf_counter()

    with concurrent.futures.ProcessPoolExecutor() as executor:
        seconds = [7, 6, 5, 4, 3, 2, 1]
        results = [executor.submit(do_something, sec) for sec in seconds]

        for f in concurrent.futures.as_completed(results):
            print(f.result())

    finish = time.perf_counter()

    print(f"Finished in {round(finish - start, 6)} second(s)")


def do_something(seconds):
    print(f"Sleeping for {seconds} second(s)...")
    time.sleep(seconds)
    return f"Done Sleeping...{seconds} second(s)"


if __name__ == "__main__":
    main()
