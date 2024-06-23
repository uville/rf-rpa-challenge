"""Helper functions."""

from robot.api.deco import keyword

from pandas import read_excel


@keyword("Read XLSX To Dictionary")
def read_xlsx_to_dictionary(path: str, sheetname: str) -> dict:
    """Read Excel file, trim column names and return as a dictionary.

    Args:
        path (str): filepath for Excel file
        sheetname (str): sheetname from where to read data

    Returns:
        data (dict): Excel content transformed to a dictionary
    """
    df = read_excel(path, sheetname)
    df.columns = df.columns.str.strip()
    return df.to_dict(orient="records")
