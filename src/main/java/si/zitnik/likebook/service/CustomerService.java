package si.zitnik.likebook.service;

import si.zitnik.likebook.domain.Campaign;
import si.zitnik.likebook.domain.Customer;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: slavkoz
 * Date: 5/10/13
 * Time: 6:48 PM
 * To change this template use Campaign | Settings | Campaign Templates.
 */
public interface CustomerService {
    public void save(Customer document);
    public List<Customer> list();
    public Customer get(Long id);
    public void remove(Long id);
}
