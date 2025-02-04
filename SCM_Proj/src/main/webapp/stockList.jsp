<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.scm.model.StockDTO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Stock List</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h2>Stock Prices</h2>
    <table>
        <tr>
            <th>Company Code</th>
            <th>Date</th>
            <th>Open</th>
            <th>High</th>
            <th>Low</th>
            <th>Close</th>
            <th>Volume</th>
            <th>Details</th>
        </tr>
        <% 
            List<StockDTO> stockList = (List<StockDTO>) request.getAttribute("stockList");
            if (stockList != null && !stockList.isEmpty()) {
                for (StockDTO stock : stockList) {
        %>
        <tr>
            <td><%= stock.getCompanyCode() %></td>
            <td><%= stock.getDate() %></td>
            <td><%= stock.getOpen() %></td>
            <td><%= stock.getHigh() %></td>
            <td><%= stock.getLow() %></td>
            <td><%= stock.getClose() %></td>
            <td><%= stock.getVolume() %></td>
            <td>
                <a href="stock?companyCode=<%= stock.getCompanyCode() %>&date=<%= stock.getDate() %>">
                    View Details
                </a>
            </td>
        </tr>
        <% 
                }
            } else { 
        %>
        <tr>
            <td colspan="8">No stock data available</td>
        </tr>
        <% } %>
    </table>
</body>
</html>
