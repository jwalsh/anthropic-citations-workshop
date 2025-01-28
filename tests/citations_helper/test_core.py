"""Test core citation functionality."""

import pytest
from modules.citations_helper.core import process_citations, extract_quotes

def test_process_citations():
    """Test basic citation processing."""
    sample_response = {
        "text": "Sample text with citation",
        "citations": [{"text": "citation", "source": "document"}]
    }
    result = process_citations(sample_response)
    assert result is not None

def test_extract_quotes():
    """Test quote extraction."""
    sample_text = "Text with 'quoted content' inside."
    quotes = extract_quotes(sample_text)
    assert quotes == ["quoted content"]
