import time
import concurrent.futures


def main():
    start = time.perf_counter()

    with concurrent.futures.ProcessPoolExecutor() as executor:
        f1 = executor.submit(do_something, 1)
        f2 = executor.submit(do_something, 1)
        
        print(f1.result())
        print(f2.result())

    finish = time.perf_counter()

    print(f"Finished in {round(finish - start, 6)} second(s)")


def do_something(seconds):
    print(f"Sleeping for {seconds} second(s)...")
    time.sleep(seconds)
    return f"Done Sleeping...{seconds} second(s)"


if __name__ == "__main__":
    main()
