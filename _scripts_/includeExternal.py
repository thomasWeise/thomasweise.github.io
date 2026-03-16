"""
Include external content into a file.

This script downloads stuff from external URLs and puts it into files.
It offers the `{{download [url]}}` directive, which will be replaced with the
contents of the file at the given url.
"""
import sys
from re import Match, Pattern, subn
from re import compile as re_compile
from typing import Final

# noinspection PyPackageRequirements
from certifi import where
from pycommons.io.console import logger
from pycommons.io.path import UTF8, Path, file_path
from pycommons.net.url import URL

# noinspection PyPackageRequirements
from urllib3 import PoolManager  # type: ignore

PATTERN: Final[Pattern] = re_compile(r"\{\{\s*download\s+(http[s]://.+)\s*\}\}")


def replace(match: Match,
            http: PoolManager = PoolManager(
                cert_reqs="CERT_REQUIRED", ca_certs=where())) -> str:
    """
    Replace the given match with the downloaded URL.

    :param match: the match
    :return: the downloaded text
    """
    url_str: Final = str.strip(match.group(1))
    url: Final[URL] = URL(url_str)
    logger(f"Found url {url!r}. Now downloading it.")
    body = http.request(method="GET", url=url).data.decode(UTF8)
    bl = str.__len__(body)
    logger(f"Downloaded {bl} characters.")
    if bl <= 0:
        raise ValueError("Invalid body length 0.")
    return str.rstrip("\n".join(map(str.rstrip, str.split(str.rstrip(
        body), "\n"))))


def process_file(file: str) -> None:
    """
    Process a file.

    :param file: the file to process
    """
    path: Final[Path] = file_path(file)
    logger(f"Now processing downloads inside file {path!r}.")
    orig_text: Final[str] = path.read_all_str()
    text: str = str.rstrip("\n".join(map(str.rstrip, str.split(str.rstrip(
        orig_text), "\n"))))
    attempts: int = 0
    while True:
        attempts += 1
        if attempts > 10:
            raise ValueError("More than 10 recursive replacements.")
        text, nrep = subn(PATTERN, replace, text)
        if nrep <= 0:
            break

    text = str.rstrip("\n".join(map(str.rstrip, str.split(str.rstrip(
        text), "\n"))))
    if orig_text == text:
        logger("Nothing to do.")
        return
    logger("Text changed after processing, so writing it out.")
    path.write_all_str(text)


def process_recursive(path: str) -> None:
    """
    Recursively process a given folder.

    :param path: the root path
    """
    the_path: Final[Path] = Path(path)
    logger(f"Now processing {the_path!r}.")
    if the_path.is_file():
        if the_path.endswith((".md", ".html")):
            process_file(the_path)
    elif the_path.is_dir():
        for subpath in the_path.list_dir():
            process_recursive(subpath)


if __name__ == "__main__":
    logger(f"Invoked program with arguments {sys.argv!r}.")
    process_recursive(sys.argv[1])
    logger("Done.")
